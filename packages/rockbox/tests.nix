{ hasBinary, rockbox, stdenv }:

if stdenv.isDarwin then null else hasBinary rockbox "mks5lboot"
