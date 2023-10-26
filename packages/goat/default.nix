{ cacert, git, go, runCommand }:

# FIXME: Better to use niv instead of go get, somehow
runCommand "goat" {
  __noChroot = true;
  buildInputs = [ git go ];
  GIT_SSL_CAINFO = "${cacert}/etc/ssl/certs/ca-bundle.crt";
} ''
  mkdir "$out"
  cd "$out"

  GOPATH="$PWD" HOME="$PWD" go get github.com/blampe/goat
''
