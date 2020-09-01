{ hasBinary, isBroken, linkchecker }:

{
  hasBinary = hasBinary linkchecker "linkchecker";

  stillNeedsDisabledTests = isBroken (linkchecker.overridePythonAttrs (old: {
    doCheck = true;
  }));
}
