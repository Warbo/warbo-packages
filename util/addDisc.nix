# Generates shell code for looking up a given disc using content-link, and
# appending it to a temporary m3u playlist.
# Useful for emulating games which have multiple discs.
{ lib }:
with {
  inherit (builtins) attrNames attrValues head length replaceStrings;
  inherit (lib) escapeShellArg;
};
disc:
assert
  length (attrNames disc) == 1
  || abort ''Each disc should be a single {name: hash} attrset'';
with rec {
  label = head (attrNames disc);
  hash = head (attrValues disc);
  link = escapeShellArg (replaceStrings [ " " "/" ] [ "_" "_" ] label);
};
''
  LOC=$(content-link get ${escapeShellArg hash}) || {
    echo "content-link registry does not contain ${label}"
    exit 1
  } 1>&2
  ln -s "$LOC" "$temp_dir"/${link}
  printf '%s\n' ${link} >> "$m3u_file"
''
