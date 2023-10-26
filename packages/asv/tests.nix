{ asv, hasBinary, isBroken }:

{
  haveCmd = hasBinary asv "asv";

  stillNeedToDisableTests =
    isBroken (asv.overridePythonAttrs (old: { doCheck = true; }));
}
