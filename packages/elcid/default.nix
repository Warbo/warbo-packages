{ buildEnv, cacert, go, git, runCommand }:

# FIXME: We should replace 'go get' with niv somehow
with rec {
  goGet = name: pre: runCommand "go-get"
    {
      __noChroot     = true;
      buildInputs    = [ go git ];
      GIT_SSL_CAINFO = "${cacert}/etc/ssl/certs/ca-bundle.crt";
    }
    ''
      ${pre}
      GOPATH="$PWD" HOME="$PWD" go get ${name}

      mkdir -p "$out"
      cp -r ./bin "$out"/
    '';

  elcid = goGet "github.com/whyrusleeping/elcid" ''
    GOPATH="$PWD" go get github.com/whyrusleeping/elcid || true
    pushd src/github.com/whyrusleeping/elcid
      git checkout "9bcd412e289dae0e2d7b7039a1be33c5bc24ab38"
    popd
  '';

  bases = goGet "github.com/whyrusleeping/bases" "";

};

{
  pkg   = buildEnv { name = "elcid"; paths = [ bases elcid ]; };
  tests = {};
}
