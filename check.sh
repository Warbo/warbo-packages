#!/usr/bin/env bash
set -e

# Simple, quick sanity check. Useful as a git pre-commit hook.

find . -name "*.nix" | while read -r F
do
    echo "Checking syntax of '$F'" 1>&2
    nix-instantiate --parse "$F" > /dev/null
done

echo "Evaluating release.nix" 1>&2
nix-instantiate -v --show-trace release.nix || {
    echo "Couldn't evaluate all test derivations" 1>&2
    exit 1
}
