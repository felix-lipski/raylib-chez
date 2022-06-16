{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = { nixpkgs, self, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem
      (system:
      let 
        pkgs = import nixpkgs {
          config = { allowUnfree = true; };
          inherit system;
        };
      in {
        devShell =
          pkgs.mkShell {
            buildInputs = with pkgs; [ chez chez-srfi ];
            shellHook = ''
              export LD_LIBRARY_PATH=${pkgs.raylib}/lib
              export LIBRARY_PATH=${pkgs.raylib}/lib
              echo ${pkgs.raylib}
            '';
          };
        }
      );
}
