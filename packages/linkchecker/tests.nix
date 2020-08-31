{ hasBinary, isBroken, linkchecker }:

{
  hasBinary = hasBinary linkchecker "linkchecker";

  stillNeedsDisabledTests = isBroken (linkchecker.overrideAttrs (old: {
    doCheck = true;
  }));
}
