{ system ? builtins.currentSystem }:
name: drv:
if system == "aarch64-linux" then
  builtins.trace "Skipping ${name}, which is not defined for ${system}" { }
else
  drv
