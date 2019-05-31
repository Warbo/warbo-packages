# Upstream mu requires Emacs to build mu4e and Guile to allow scripting. If we
# just want the command line tools, we can do without those heavy dependencies.
{ mu }:

{
  pkg   = mu.override { emacs = null; guile = null; };
  tests = {};
}
