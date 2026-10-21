# Open CLI login links in the Chrome "Work" profile

Chrome has no "default profile" setting: `open https://...` lands in whichever
profile was used last. CLIs that start a browser OIDC flow (`vault login
-method=oidc`, `vdev`/`vprod`, `cmd/` scripts in infra-core) therefore
sometimes open the wrong profile and the login fails or uses the wrong account.

The Vault CLI opens the browser by running `open <url>` (looked up via PATH).
`BROWSER` is ignored on macOS. So a PATH shim named `open` can pick the profile.

## Find the profile directory

The directory name is not the display name. In the Work profile open
`chrome://version` and read the last part of **Profile Path**
(here: `Profile 1`).

## Install

1. Create `~/.local/bin/open`:

```bash
#!/bin/bash
# PATH shim for macOS `open`: send a single http(s) URL to a fixed Chrome
# profile instead of whichever profile was used last. Everything else is
# passed through to /usr/bin/open untouched.
# Set OPEN_SHIM_DRYRUN=1 to print the command instead of running it.
set -eu

readonly CHROME_PROFILE_DIR="${CHROME_PROFILE_DIR:-Profile 1}" # "Work"

if [ "$#" -eq 1 ] && [[ "$1" =~ ^https?:// ]]; then
  cmd=(/usr/bin/open -na "Google Chrome" --args "--profile-directory=${CHROME_PROFILE_DIR}" "$1")
else
  cmd=(/usr/bin/open "$@")
fi

if [ "${OPEN_SHIM_DRYRUN:-}" = "1" ]; then
  printf '%q ' "${cmd[@]}"; echo
  exit 0
fi
exec "${cmd[@]}"
```

2. `chmod +x ~/.local/bin/open`
3. Put `~/.local/bin` **before** `/usr/bin` on PATH, e.g. in `~/.zshrc`:
   `export PATH="$HOME/.local/bin:$PATH"`

## Verify

```bash
type -a open                                   # ~/.local/bin/open must come first
OPEN_SHIM_DRYRUN=1 open https://example.com    # shows --profile-directory=Profile 1
OPEN_SHIM_DRYRUN=1 open -R ~/Downloads         # passes through to /usr/bin/open
```

## Notes

- Scope: only processes that resolve `open` via PATH. GUI apps, `/usr/bin/open`
  called by absolute path, and Finder are unaffected.
- Only a single `http(s)` URL argument is redirected; `open file`, `open -a`,
  `open -R` etc. are untouched.
- `open -na "Google Chrome" --args --profile-directory=...` hands the URL to the
  running Chrome instance (new tab in that profile) or starts Chrome if closed.
- Override per call with `CHROME_PROFILE_DIR="Default" vault login ...`.
- Headless alternative: `vault login -method=oidc skip_browser=true` prints the
  URL; open it in any profile, the callback on `localhost:8250` completes login.
