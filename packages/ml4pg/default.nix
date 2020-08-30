{ callPackage, gitSource, nothing }:

{
  pkg = builtins.trace "ML4PG disabled" nothing/*
  callPackage (gitSource { name = "ml4pg"; }) {}
  */;
  tests = {};
}
