self: _: helf: _:

helf.callPackage (self.gitHaskell { name = "get-deps"; }) { }
