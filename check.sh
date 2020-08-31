#!/usr/bin/env bash
set -e

# Simple, quick sanity check. Useful as a git pre-commit hook.

function fail {
    echo "$*" 1>&2
    exit 1
}

find . -name "*.nix" -type f | while read -r F
do
    echo "Checking syntax of '$F'" 1>&2
    nix-instantiate --parse "$F" > /dev/null
done

echo "Performing Nix checks" 1>&2
nix-instantiate --eval --read-write-mode \
    -E '(import ./check.nix) || builtins.abort "Check failed"'

echo "Checking that haskell-nix derivations are cached" 1>&2
grep -R -l 'haskell-nix {' | grep '\.nix$' | while read -r F
do
    grep 'plan-sha256' < "$F" > /dev/null || {
        echo "File '$F' uses haskell-nix without caching a plan-sha256" 1>&2
        fail "Build the package and follow the instructions in 'trace'"
    }
    grep 'materialized' < "$F" > /dev/null || {
        echo "File '$F' uses haskell-nix without a materialised plan"   1>&2
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

       FOUNDNAME=$(grep 'identifier' < "$X"      |
                   grep -o 'name *= *"[^"]*"'    |
                   grep -o '"[^"]*"'             ) || fail "No name in '$X'"
    FOUNDVERSION=$(grep 'identifier' < "$X"      |
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
