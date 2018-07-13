with builtins;
with import ./.;
removeAttrs warbo-packages [ "haskell" "warbo-packages" ] // {
  haskellPackages = listToAttrs (map (name: {
                                       inherit name;
                                       value = getAttr name haskellPackages;
                                     })
                                     warbo-packages-haskell-names);
}
