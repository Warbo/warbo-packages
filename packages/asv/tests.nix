{ asv, hasBinary, isBroken }:

{
  haveCmd = hasBinary asv "asv";

  stillNeedToDisableTests = isBroken (asv.overrideAttrs (old: {
    doCheck = true;
  }));
}
