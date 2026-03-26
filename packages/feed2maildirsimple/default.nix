# TODO: Create a pkarr URL, push latest version to it, then update this (and
# annotate for update-git-refs)
{
  fetchGitIPFS,
  nixpkgs ? pkgs,
  pkgs,
}:
import (fetchGitIPFS { sha1 = "b09784865958c98bbe88478b143d9a769a08cb0b"; }) {
  inherit nixpkgs;
}
