{
  hasBinary,
  kbibtex_full,
  skipMac,
}:

skipMac "kbibtex tests" (hasBinary kbibtex_full "kbibtex")
