# Windows Hello (TPM)-backed SSH key for git auth + commit signing

Windows sibling to `tpm-ssh-git-signing.md` (Linux) and `secure-enclave-ssh-git-signing.md` (macOS). Windows reaches the TPM through Windows Hello's FIDO2 platform authenticator, so the key is an OpenSSH security-key credential (`sk-ecdsa-sha2-nistp256@openssh.com`) whose private half is sealed in the TPM and gated by a Hello PIN or biometric on every use.

**Not in use.** Every step below is tested end to end, up to a "Verified" badge on GitHub, so the blocker is not correctness. Windows Hello has no verification cache, so this setup demands a PIN or biometric on *every* commit and *every* push, where the Linux TPM key caches its passphrase per login session and Secretive on macOS asks for nothing. Windows therefore stays on its YubiKey, whose PIN `gpg-agent` caches per session.

Tool: OpenSSH for Windows, **10.0p2 or newer**. Nothing third-party. The in-box 9.5p2 cannot enroll a Hello key at all, see Notes.

## 🔧 Steps

1. **Install OpenSSH 10.0 Preview.** The in-box build is too old and cannot be upgraded in place:

   ```powershell
   winget install --id Microsoft.OpenSSH.Preview --exact
   ```

   The MSI puts `C:\Program Files\OpenSSH\` ahead of `C:\Windows\System32\OpenSSH\` in the machine PATH. Open a **new** shell and confirm `ssh -V` reports `OpenSSH_for_Windows_10.0p2`; already-running shells keep resolving to the old binaries. Revert with `winget uninstall Microsoft.OpenSSH.Preview`.

2. **Generate the key.** Windows Hello prompts for PIN or biometric and creates the credential in the TPM. Press Enter at both passphrase prompts, a passphrase is pointless here (see Notes):

   ```powershell
   ssh-keygen -t ecdsa-sk -f "$env:USERPROFILE\.ssh\id_ecdsa_sk" -C "$env:USERNAME@$env:COMPUTERNAME-tpm"
   ```

   Produces `id_ecdsa_sk.pub` (normal pubkey) and `id_ecdsa_sk` (a FIDO credential handle, useless without this TPM). Only `ecdsa-sk` works, `ed25519-sk` is impossible on Windows Hello.

3. **Never run `ssh-add` on this key.** The Windows agent accepts it and then cannot release it: `ssh-add -d` answers `agent refused operation`, `ssh-add -D` reports success while the key stays listed, and it persists in `HKCU:\Software\OpenSSH\Agent\Keys` across reboots. Clearing it takes an elevated `Restart-Service ssh-agent -Force`. No agent is needed, the credential handle file reaches the TPM on its own.

4. **Point SSH auth at it** in `~/.ssh/config`. `IdentitiesOnly yes` matters: without it the agent's other identities get offered first.

   ```
   Host github.com
       IdentityFile C:/Users/<user>/.ssh/id_ecdsa_sk
       IdentitiesOnly yes
   ```

5. **Point git at it.** Absolute paths throughout, because git otherwise picks up whichever `ssh`/`ssh-keygen` its own bundle or `System32` provides:

   ```powershell
   git config --global gpg.format ssh
   git config --global user.signingkey "C:/Users/<user>/.ssh/id_ecdsa_sk.pub"
   git config --global gpg.ssh.program "C:/Program Files/OpenSSH/ssh-keygen.exe"
   git config --global gpg.ssh.allowedSignersFile "C:/Users/<user>/.ssh/allowed_signers"
   git config --global core.sshCommand "'C:/Program Files/OpenSSH/ssh.exe'"
   git config --global commit.gpgsign true
   ```

   The single quotes nested inside `core.sshCommand` are load-bearing. Git hands that value to `sh -c`, which splits it on the space in `Program Files` and fails with `C:/Program: No such file or directory`. `gpg.ssh.program` is not shelled out and needs no such quoting.

   No signing wrapper script, unlike the Linux and macOS notes. Those need one because `ssh-keygen -Y sign` reads `SSH_AUTH_SOCK` and has to be pointed at the right agent; here there is no agent and it reads the credential handle file directly.

6. **Write the allowed signers file**, using an email verified on the GitHub account:

   ```powershell
   "<git-email> $(Get-Content $env:USERPROFILE\.ssh\id_ecdsa_sk.pub)" | Set-Content -Encoding ascii $env:USERPROFILE\.ssh\allowed_signers
   ```

   `-Encoding utf8` writes a BOM in Windows PowerShell 5.1, which lands in the principal name.

7. **Register the public key on GitHub** at github.com/settings/keys, twice: once as an **Authentication key**, once as a **Signing key**. `gh ssh-key add` needs the `admin:public_key` and `admin:ssh_signing_key` scopes, which a default `gh auth login` token does not carry.

8. **Verify**: `ssh -T git@github.com` greets you, and a commit shows `Good "git" signature` under `git log --show-signature` and "Verified" on GitHub.

## 📝 Notes

- **Why the in-box OpenSSH will not do.** Windows Hello returns a credential with no attestation. OpenSSH 9.5 and earlier still run `fido_cred_verify_self` on it and abort with `Key enrollment failed: invalid format`. OpenSSH 10.0 skips verification when the attestation format is `none`, which is the entire fix. Upstream never merged a libfido2-side fix ([libfido2#840](https://github.com/Yubico/libfido2/issues/840) open, [openssh-portable#542](https://github.com/openssh/openssh-portable/pull/542) closed unmerged), so waiting for the in-box build to catch up means waiting for Windows to ship OpenSSH 10. Tracked as [Win32-OpenSSH#2040](https://github.com/PowerShell/Win32-OpenSSH/issues/2040) and [#2279](https://github.com/PowerShell/Win32-OpenSSH/issues/2279).

- **Preview build.** Microsoft labels 10.0.0.0p2 preview and non-production. It is Microsoft-signed and installed through winget from the Win32-OpenSSH release, and it replaces only the client tools; the in-box copy stays in `System32` untouched.

- **Ed25519 is impossible, not merely awkward.** Windows Hello's platform authenticator implements ES256 only. Ask for `ed25519-sk` and the Windows credential picker silently drops "this device" and offers only a phone or a USB security key, which looks like a missing-device bug and is really an unsupported-algorithm one. Same NIST P-256 outcome as the Linux TPM and macOS Secure Enclave notes, different cause.

- **A Hello prompt on every single operation.** Every commit and every `git push` raises a Windows Security dialog. There is no cache and no timeout ([Win32-OpenSSH#2225](https://github.com/PowerShell/Win32-OpenSSH/issues/2225)). This is the one place where the three notes genuinely diverge: the Linux TPM key caches its passphrase per session and Secretive's `Notify` asks for nothing at all, while this is the equivalent of Secretive's `Require Authentication`. Enrolling a fingerprint or face turns it into a gesture rather than typing.

- **A local `Good "git" signature` is weaker evidence than it looks.** `git log --show-signature` reports whichever principal in `allowed_signers` carries that key, so a wrong email there still prints a good signature under that wrong name. Only an empty or key-less file produces `No principal matched`. GitHub ignores the file entirely and requires the commit author email to be verified on the account, so the "Verified" badge is the only real test.

- **Credentials show up under Settings, Accounts, Passkeys** as `ssh:` entries, one per key generated. Stale ones are reported to make Hello vanish from the credential picker ([Win32-OpenSSH#2408](https://github.com/PowerShell/Win32-OpenSSH/issues/2408)); delete them there if that happens.

- **A TPM reset destroys the key.** Clearing the TPM, and on many desktop boards a UEFI update, wipes it with no recovery path. Keep a second authentication and signing method registered on GitHub before relying on this one.

- **Is this as secure as a YubiKey?** Closer than the Linux and macOS setups are.
  - **Matches:** non-exportability. The private key never leaves the TPM, so disk theft, OS compromise or forensic imaging yield nothing usable.
  - **Exceeds the sibling setups:** user verification is enforced per operation, with no cache to steal a window from. A YubiKey with a cached PIN is weaker on this axis.
  - **Structural difference that remains:** the same one the other two notes carry. The TPM is soldered to this machine, so there is no equivalent of unplugging a security key to revoke signing capability mid-session.

- **Routes that do not work.** `ssh-tpm-agent`, the tool the Linux note uses, is Linux-only and upstream declines to support Windows ([#134](https://github.com/Foxboron/ssh-tpm-agent/issues/134)). [`openssh-sk-winhello`](https://github.com/tavrez/openssh-sk-winhello) would bypass the libfido2 bug, but its last release targets the OpenSSH 8.4 provider API and current OpenSSH rejects it.

- **The route that trades supply chain for comfort.** [nCryptAgent](https://github.com/unreality/nCryptAgent) drives the TPM through the Microsoft Platform Crypto Provider instead of FIDO, avoiding all of the above and offering a configurable PIN cache, which is much closer to the Linux experience. Its newest release is a v0.0.7 prerelease from February 2024, which does not meet the bar the Linux note set for a tool trusted with a signing key.
