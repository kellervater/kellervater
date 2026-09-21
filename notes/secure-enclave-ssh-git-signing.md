# Secure Enclave-backed SSH key for git auth + commit signing

macOS sibling to `tpm-ssh-git-signing.md`. No TPM on macOS - the hardware
root is the **Secure Enclave** (all Apple Silicon and T2 Intel Macs).

Tool: [`Secretive`](https://github.com/maxgoedjen/secretive) (MIT, Max
Goedjen, Swift, no external deps, attested GitHub Actions builds since 3.0).
Stores the key in the Secure Enclave via Keychain - same non-exportability
as the TPM.

## Steps

1. **Install:**

```bash
brew install secretive
```

2. **First launch**: onboarding screen makes you check off 3 items
   (activate agent, notifications, one more) before `+` unlocks.

3. **Generate a key** (`+` button):
   - Name: e.g. `github`
   - Protection Level: **Notify** (see Notes - `Require Authentication` has
     no timeout/cache, it's Touch ID on every single operation)
   - Click **Advanced** → key type: 3 choices shown, pick **ECDSA-256**
     (the Secure-Enclave-backed one - the other 2 are software-only
     fallbacks for Macs without a Secure Enclave, not what we want)

4. **Get the pubkey onto disk.** Secretive does *not* write a `.pub` file
   for you - copy it from the app UI and save it yourself:

```bash
mkdir -p ~/.ssh
cat > ~/.ssh/id_ecdsa_github.pub << 'EOF'
<paste the pubkey Secretive shows you>
EOF
```

5. **Point SSH at the agent** - `~/.ssh/config`:

```
Host github.com
    IdentityAgent "~/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh"
    IdentityFile ~/.ssh/id_ecdsa_github.pub
    IdentitiesOnly yes
```

6. **Commit signing.** Git's SSH-format signing (`gpg.ssh.program`, default
   `ssh-keygen -Y sign -U`) reads `SSH_AUTH_SOCK` directly - it ignores
   `~/.ssh/config`, so the `IdentityAgent` above doesn't help here (same gap
   as the TPM doc). Point signing at Secretive's socket with a small wrapper:

```bash
cat > ~/.local/bin/git-ssh-secretive-sign << 'EOF'
#!/bin/sh
export SSH_AUTH_SOCK="$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh"
exec ssh-keygen "$@"
EOF
chmod +x ~/.local/bin/git-ssh-secretive-sign

git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/id_ecdsa_github.pub
git config --global gpg.ssh.program ~/.local/bin/git-ssh-secretive-sign
git config --global gpg.ssh.allowedSignersFile ~/.ssh/allowed_signers
echo "<git-email> $(cat ~/.ssh/id_ecdsa_github.pub)" > ~/.ssh/allowed_signers
```

7. **Set the commit identity** on a fresh machine - `<git-email>` must be an
   email verified on the GitHub account, otherwise commits land as
   "Unverified" (see Notes):

```bash
git config --global user.name "<name>"
git config --global user.email "<git-email>"
```

8. **Register the pubkey on GitHub** - as both Authentication key and
   Signing key → github.com/settings/keys

9. **Verify**: `ssh -T git@github.com` greets you; `git commit -S` shows
   "Verified" on GitHub.

## Notes

- Supply-chain check before trusting it with signing: no CVEs, GitHub
  Artifact Attestation on builds since 3.0, actively maintained.

- **Why the signing wrapper (step 6) is needed**: Secretive's own FAQ says
  `git`/`ssh` "natively respect" `SSH_AUTH_SOCK` - the `IdentityAgent` line
  in `~/.ssh/config` only covers the `ssh` binary for host-matched
  connections (auth). `ssh-keygen -Y sign`, used for commit signing, has no
  host context and reads `SSH_AUTH_SOCK` directly, so without the wrapper
  it queries whatever the default agent is (macOS's built-in one, which
  doesn't know about Secretive's keys) and signing fails silently until
  you dig into it.

- **"Unverified" on GitHub despite a good local signature**: `git log
  --show-signature` only checks the signature against
  `~/.ssh/allowed_signers`, GitHub additionally requires the commit's author
  email to be a verified email on the account. With no `user.email` set, git
  silently derives one from username and hostname
  (`<user>@<host>.local`), which is unverifiable, so every commit shows
  "Unverified" while verifying fine locally. `commit.gpgsign` is also off by
  default, so commits go unsigned unless `-S` is passed:
  `git config --global commit.gpgsign true` to sign always.

- **Notify vs. TPM security**: non-exportability matches (key never leaves
  hardware either way). UX-wise also matches - the TPM's passphrase is
  cached per session by default, so both land at "no interaction most of
  the time." Gap: `Notify` has zero presence check at all, vs. the TPM's
  one-passphrase-per-session. `Require Authentication` closes that gap but
  costs Touch ID on every operation - Secretive has no timeout/cache option
  in between (confirmed upstream: [discussion #338](https://github.com/maxgoedjen/secretive/discussions/338)).
  Structural gap stays either way: Secure Enclave is soldered to this Mac,
  no "unplug it" like a hardware key.

- **Watch item**: macOS Tahoe added native Secure Enclave SSH keys
  (`ssh-keygen -K`, via `/usr/lib/ssh-keychain.dylib`), no third-party app.
  Too new to trust yet, revisit later.

- **Update nag**: Secretive's in-app "Update available" notification can't
  actually update a brew-installed copy - clicking it just opens the
  releases page. Ignore it, use `brew upgrade --cask secretive` instead.