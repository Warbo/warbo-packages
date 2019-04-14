{ qtbase, super }:

{
  pkg = super.rockbox_utility.override (old: { inherit qtbase; });
}
