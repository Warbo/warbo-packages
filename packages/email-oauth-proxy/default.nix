{
  fetchTreeFromGitHub,
  python3Packages,
}:
with {
  go =
    {
      buildPythonApplication,
      cryptography,
      prompt-toolkit,
      pyasyncore,
      pyjwt,
      setuptools,
    }:
    buildPythonApplication rec {
      pname = "email-oauth2-proxy";
      version = "0a2e384b14fcf0aa33539b1b735ba34d61c16f4f";
      format = "pyproject";
      src = fetchTreeFromGitHub {
        owner = "simonrob";
        repo = pname;
        tree = version;
      };
      nativeBuildInputs = [
        cryptography
        prompt-toolkit
        pyasyncore
        pyjwt
        setuptools
      ];
    };
};
python3Packages.callPackage go { }
