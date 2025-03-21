{ python3, writeShellApplication }:
with {
  go = {buildPythonPackage, fetchPypi, setuptools}: buildPythonPackage rec {
    pname = "flameprof";
    version = "0.4";
    pyproject = true;
    buildInputs = [ setuptools ];
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-28htQZDLu6Yk8eCkD0TZ25YTjidTTYPI70LUIIV4daM=";
    };
  };
};
writeShellApplication {
  name = "flameprof";
  runtimeInputs = [ (python3.withPackages (p: [ (p.callPackage go {}) ])) ];
  text = ''flameprof "$@"'';
}
