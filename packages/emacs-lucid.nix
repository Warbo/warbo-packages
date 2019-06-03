  # GTK crashes if X restarts, plus GTK3 is horrible and it's slow. This version
  # forces the "lucid" GUI (AKA Xaw3D)
{ emacs, hasBinary, lib }:

rec {
  pkg   = lib.makeOverridable ({ emacs }: emacs.override {
                                withGTK2 = false;
                                withGTK3 = false;
                              })
                              { inherit emacs; };
  tests = hasBinary pkg "emacs";
}
