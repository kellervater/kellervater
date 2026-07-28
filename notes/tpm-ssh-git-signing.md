# TPM-backed SSH key for git auth + commit signing

How to use the laptop's built-in TPM 2.0 chip to generate an SSH key and use
it for both `git push`/`pull` (SSH auth) and commit signing — as an
alternative to GPG + a hardware security key (e.g. a YubiKey). Seals the key
inside the TPM: non-exportable, bound to this specific machine.

Tool: [`ssh-tpm-agent`](https://github.com/Foxboron/ssh-tpm-agent) (MIT,
maintained by an Arch Linux security-team dev, packaged in Arch `extra` and
nixpkgs). Pinned to **v0.9.0** below — the exact version audited before
trusting it with signing keys (see Notes).

## Steps

1. **TPM device access** — the TPM device (`/dev/tpmrm0`) is owned by the
   `tss` group; add yourself to it and re-login:
   ```bash
   sudo usermod -aG tss "$USER"   # then log out/in (or reboot)
   ```

2. **Install** (built from source via Go, since no distro package existed):
   ```bash
   GOBIN="$HOME/.local/bin" go install github.com/foxboron/ssh-tpm-agent/cmd/ssh-tpm-agent@v0.9.0
   GOBIN="$HOME/.local/bin" go install github.com/foxboron/ssh-tpm-agent/cmd/ssh-tpm-keygen@v0.9.0
   ```

3. **Generate a sealed key** (TPM 2.0 only supports RSA/ECDSA — no Ed25519):
   ```bash
   ssh-tpm-keygen -t ecdsa -b 384 -N '' -C "$USER@$(hostname)-tpm" -f ~/.ssh/id_ecdsa_tpm
   ```
   Produces `id_ecdsa_tpm.pub` (normal pubkey) and `id_ecdsa_tpm.tpm` (a
   TSS2-wrapped blob — useless outside this TPM, even if stolen).

4. **Add a passphrase** (recommended — see Notes for why):
   ```bash
   ssh-tpm-keygen -p -f ~/.ssh/id_ecdsa_tpm.tpm
   ```
   ⚠️ **Known upstream bug** (still present in v0.9.0/`main` as of writing,
   reported as [Foxboron/ssh-tpm-agent#133](https://github.com/Foxboron/ssh-tpm-agent/issues/133)):
   the old/new passphrase arguments are swapped internally, so answering the
   prompts normally fails with `TPM_RC_AUTH_FAIL`. Workaround — answer in
   swapped order: type your **desired new passphrase** at "Enter old
   passphrase", then leave both "Enter new passphrase" prompts **empty**.

5. **Run the agent as a systemd user service** (socket-activated, starts on
   demand):
   ```bash
   ssh-tpm-agent --install-user-units
   systemctl --user enable --now ssh-tpm-agent.socket
   ```
   Caching stays on by default (asks for the passphrase once per login
   session, not per operation) — see Notes for the trade-off.

6. **Point SSH auth at it — scoped to the `ssh` client only**, so it doesn't
   fight any other agent already claiming the global `SSH_AUTH_SOCK` (e.g.
   GnuPG's ssh-agent emulation, common when a hardware key's OpenPGP applet
   is used for SSH). In `~/.ssh/config`:
   ```
   Host github.com
       IdentityAgent /run/user/1000/ssh-tpm-agent.sock
       IdentityFile ~/.ssh/id_ecdsa_tpm.pub
       IdentitiesOnly yes
   ```

7. **Point git commit signing at it.** Git's SSH-format signing
   (`gpg.ssh.program`, default `ssh-keygen -Y sign -U`) reads `SSH_AUTH_SOCK`
   directly — it ignores `~/.ssh/config`. So use a tiny wrapper instead of
   touching the global env var:
   ```bash
   cat > ~/.local/bin/git-ssh-tpm-sign << 'EOF'
   #!/bin/sh
   export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/ssh-tpm-agent.sock"
   exec ssh-keygen "$@"
   EOF
   chmod +x ~/.local/bin/git-ssh-tpm-sign

   git config --global gpg.format ssh
   git config --global user.signingkey ~/.ssh/id_ecdsa_tpm.pub
   git config --global gpg.ssh.program ~/.local/bin/git-ssh-tpm-sign
   git config --global gpg.ssh.allowedSignersFile ~/.ssh/allowed_signers
   echo "<git-email> $(cat ~/.ssh/id_ecdsa_tpm.pub)" > ~/.ssh/allowed_signers
   ```

8. **Register the public key on GitHub** — as *both*:
   - **Authentication key** → github.com/settings/keys
   - **Signing key** → github.com/settings/keys

9. **Verify**: `ssh -T git@github.com` should greet you; a `git commit -S`
   should show up as "Verified" on GitHub.

## Notes

- **Supply-chain check** before trusting the tool with signing keys: no
  CVEs/advisories, signed releases, official Arch/nixpkgs packaging,
  maintainer is a known Arch Linux security-team developer, and the source
  has zero outbound network code (only local Unix-socket IPC). Pinned the
  install to the exact version (v0.9.0) that was actually read and audited,
  rather than trusting `@latest` on faith for future reinstalls.

- **Is this as secure as a hardware key (e.g. YubiKey)?** Partially, not
  fully, unless hardened — and the answer depends on the actual usage
  pattern (PIN/passphrase cached once per session vs. required per
  operation with physical touch):
  - **Matches:** non-exportability. The private key material never leaves
    the TPM either way — full disk theft, OS compromise, or forensic
    imaging can't yield usable key material.
  - **Matches, if a passphrase is set with default caching** (as configured
    above): same UX as a hardware key whose PIN is cached per session —
    type it once after boot/login, silent after that until logout/reboot.
  - **Structural difference that remains:** a hardware security key's
    crypto operation runs on the physical chip *every time*, cached PIN or
    not — so physically unplugging it instantly revokes signing
    capability, mid-session, regardless of any cache. A TPM is soldered to
    this specific laptop; there's no equivalent "remove it from the
    equation" action. This matters mainly if you'd deliberately separate
    the key from the laptop (stepping away, travel) — for the general
    malware/disk-theft/forensic threat model, a passphrase-protected TPM
    key is close to on par.
