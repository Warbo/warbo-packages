{ awf, hasBinary }:

{
  gtk2 = hasBinary awf "awf-gtk2";
  gtk3 = hasBinary awf "awf-gtk3";
}
