# TODO: Create a pkarr URL, push latest version to it, then update this (and
# annotate for update-git-refs)
{ fetchGitIPFS, nixpkgs }:
import (fetchGitIPFS { sha1 = "99ef713450d5f32b8eb6a5964ed3430906e9a776"; }) {
  inherit nixpkgs;
}
