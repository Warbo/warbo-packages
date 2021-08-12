{ hasBinary, rockbox, skipMac }:

skipMac "rockbox tests" (hasBinary rockbox "mks5lboot")
