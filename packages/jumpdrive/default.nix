# Currently doesn't work, since it's trying to build busybox etc. itself, and
# that doesn't like Nix's sandbox
{
  fetchTreeFromGitHub,
  stdenv,
  writeShellApplication,
}:
with rec {
  bb = "busybox-1.32.0.tar.bz2";
  bbTar = builtins.fetchurl {
    url = "https://www.busybox.net/downloads/${bb}";
    sha256 = "sha256:12g63zsvzfz04wbyga8riyl8ils05riw4xf26cyiaasbs3qqfpf3";
  };
};
stdenv.mkDerivation {
  name = "jumpdrive";
  src = fetchTreeFromGitHub {
    owner = "dreemurrs-embedded";
    repo = "Jumpdrive";
    tree = "ed467030aae8df0503dc5489348e03674752fd8d";
  };
  buildInputs = [
    (writeShellApplication {
      name = "wget";
      text = ''
        echo "wget $*" 1>&2
      '';
    })
  ];
  preBuild = ''
    cp ${bbTar} ${bb}
  '';
}
