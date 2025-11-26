#!/usr/bin/env bash
set -e

# Simple, quick sanity check. Useful as a git pre-commit hook.

msg() { [[ -z "$DEBUG" ]] || echo "$*" 1>&2; }

CODE=0
function fail {
    DEBUG=1 msg "$@"
    CODE=1
    [[ -z "${FAILFAST:-}" ]] || exit 1
}

msg "Checking shell.nix works"
nix-shell --run true || fail "Error instantiating nix-shell"

command -v update-nix-fetchgit > /dev/null && {
    for DEP in nix-helpers
    do
        msg "Checking dependency $DEP is up to date"
        F="packages/$DEP/default.nix"
        diff "$F" <(update-nix-fetchgit < "$F") || fail "Out of date: $F"
    done
}

exit "$CODE"
