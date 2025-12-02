# Nixpkgs 25.11 introduced a breaking change in buildPythonApplication, so we
# replace that function with an alternative which acts like the old one. It's
# been raised as issue e8450004d2c6b6a7 in the artemis repo, so we can phase
#this out after that's resolved (and we're happy to break our own back-compat).
{
  python3Packages,
  python3PackagesLenient ? python3Packages.override {
    overrides = pelf: puper: {
      buildPythonApplication =
        bpaArgs:
        puper.buildPythonApplication (
          (
            if bpaArgs.pname == "artemis" then
              {
                pyproject = true;
                build-system = [ pelf.setuptools ];
              }
            else
              { }
          )
          // bpaArgs
        );
    };
  },
  fetchGitIPFS,
  ...
}@args:
import
  (fetchGitIPFS {
    sha1 = "6ea8036e6c04b73aff045acd0a5c195846454561";
  })
  (
    builtins.removeAttrs
      (
        args
        // {
          python3Packages = python3PackagesLenient;
        }
      )
      [
        "fetchGitIPFS"
        "python3PackagesLenient"
      ]
  )
