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

while read -r F
do
    msg "Checking syntax of '$F'"
    nix-instantiate --parse "$F" > /dev/null || fail "Failed to parse '$F'"
    if command -v nixfmt > /dev/null
    then
        nixfmt -c -w 80 "$F" || {
            fail "Unformatted file '$F'"
            if [[ -n "$REFORMAT" ]]
            then
                echo "Reformatting '$F'" 1>&2
                nixfmt -w 80 "$F"
            else
                echo "Set REFORMAT to auto-format" 1>&2
            fi
        }
    fi
done < <(find . -name "*.nix" -type f)

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

msg "Checking that haskell-nix derivations are cached"
grep -R -l 'haskell-nix {' | grep '\.nix$' | while read -r F
do
    grep 'plan-sha256' < "$F" > /dev/null || {
        msg "File '$F' uses haskell-nix without caching a plan-sha256" 1>&2
        fail "Build the package and follow the instructions in 'trace'"
    }
    grep 'materialized' < "$F" > /dev/null || {
        msg "File '$F' uses haskell-nix without a materialised plan"   1>&2
        fail "Build the package and follow the instructions in 'trace'"
    }

    GOT=$(grep -o '\.\./caches/[^;]*' < "$F") ||
        fail "Couldn't find any '../caches' reference in haskell-nix file '$F'"
    D=$(echo "$GOT"  | head -n1 | sed -e 's@\.\./@@g' -e 's@$@/.plan.nix@g')
    unset GOT

    [[ -d "$D" ]] || fail "Couldn't find cache directory '$D' for '$F'"
    COUNT=$(find "$D" -type f -name '*.nix' | wc -l)
    [[ "$COUNT" -gt 0 ]] || fail "No .nix files in '$D'"
    if [[ "$COUNT" -eq 1 ]]
    then
        X=$(readlink -f "$D"/*.nix)
    else
        # There are multiple files which may contain the main definition we're
        # using. Try finding one whose name also appears in $F.
        FOUND=0
        for POSSIBLE in "$D"/*.nix
        do
            N=$(basename "$POSSIBLE" .nix)
            if grep "\"$N\"" < "$F" > /dev/null
            then
                [[ "$FOUND" -eq 0 ]] ||
                    fail "Ambiguity: Multiple files in '$D' are found in '$F'"
                X="$POSSIBLE"
            fi
        done
        unset FOUND
        unset POSSIBLE
    fi

       FOUNDNAME=$(grep -A2 'identifier' < "$X"      |
                   grep -o 'name *= *"[^"]*"'    |
                   grep -o '"[^"]*"'             ) || fail "No name in '$X'"
    FOUNDVERSION=$(grep -A2 'identifier' < "$X"      |
                   grep -o 'version *= *"[^"]*"' |
                   grep -o '"[^"]*"'             ) || fail "No version '$X'"
    unset D

    # The 'hackage-package' function accepts a package name and version; other
    # functions like 'cabalProject' take them from the 'src', which may be a git
    # repo whose name is nothing like the package's
    if grep 'hackage-package' < "$F" > /dev/null
    then
        grep -F "$FOUNDNAME" < "$F" > /dev/null ||
            fail "Expected name '$FOUNDNAME' in '$F', not found"
        grep -F "$FOUNDVERSION" < "$F" > /dev/null ||
            fail "Expected version '$FOUNDVERSION' in '$F', not found"
    fi
    unset FOUNDNAME
    unset FOUNDVERSION
done

exit "$CODE"
