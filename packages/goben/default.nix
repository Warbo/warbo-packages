{ buildGoModule, fetchTreeFromGitHub }:
buildGoModule {
  pname = "goben";
  version = "0.0.0";
  vendorHash = "sha256-sDyH/csfFplvwDz0W26DqADTlQacbd4li2zlH7/cidE=";
  src = fetchTreeFromGitHub {
    owner = "hollowness-inside";
    repo = "BencodeCLI";
    tree = "db602d688d899d9f5dbbf220420aa9f1e5a6c963";
  };
}
