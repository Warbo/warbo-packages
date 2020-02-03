#!/usr/bin/env bash
set -e

# Simple, quick sanity check. Useful as a git pre-commit hook.

find . -name "*.nix" -type f | while read -r F
do
    echo "Checking syntax of '$F'" 1>&2
    nix-instantiate --parse "$F" > /dev/null
done

# Allow failure to get HEAD (e.g. in case we're offline)
echo "Checking nix-helpers version" 1>&2
if REV=$(git ls-remote "http://chriswarbo.net/git/nix-helpers.git" |
         grep HEAD | cut -d ' ' -f1 | cut -c1-7)
then
    grep "$REV" < helpers.nix || {
        echo "Didn't find nix-helpers rev '$REV' in helpers.nix" 1>&2
        exit 1
    }
    echo "Checking helpers.nix builds (e.g. that SHA256 is correct)" 1>&2
    nix-build --no-out-link helpers.nix || exit 1
fi
