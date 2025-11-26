{
  asv,
  hasBinary,
  isBroken,
}:

{
  haveCmd = hasBinary asv "asv";

  stillNeedToDisableTests = isBroken (
    asv.overridePythonAttrs (_: {
      doCheck = true;
    })
  );
}
