{
  description = "Helloyesod flake";

  inputs = {
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    haskellNix.url = "github:input-output-hk/haskell.nix";
    nixpkgs.follows = "haskellNix/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ self
                   , nixpkgs
                   , flake-utils
                   , haskellNix
                   , flake-compat
                   }:

    let
      overlays =
        [ haskellNix.overlay
          (final: prev: {
            helloyesod = final.haskell-nix.stackProject {

              src = final.haskell-nix.cleanSourceHaskell {
                src = ./.;
                name = "helloyesod";
              };

              shell.buildInputs = with pkgs; [
                stack
                # haskell.compiler.ghc
                # haskellPackages.zlib_0_7_1_0
                # nixUnstable
                # stylish-haskell
                # haskell-language-server
              ];
              shell.additional = hsPkgs: with hsPkgs; [ Cabal ];
            };
            # helloyesod-wrapper = pkgs.writeShellApplication {
            #   name = "helloyesod-wrapped";
            #   runtimeInputs = [ self.packages.x86_64-linux.default ];
            #   text = ''
            #    cd /home/omoper/helloyesod
            #    ${self.packages.x86_64-linux.default}/bin/helloyesod
            #   '';
            # };

          })
        ];
      pkgs = import nixpkgs { system = "x86_64-linux";
                              inherit overlays;
                              inherit (haskellNix) config;
                            };
      flake = pkgs.helloyesod.flake {};

    in flake-utils.lib.eachSystem [ "x86_64-linux" ] (system: flake // {
        packages = flake.packages // {
          default = flake.packages."helloyesod:exe:helloyesod";
          helloyesod-wrapper = pkgs.helloyesod-wrapper;
        };
        apps = flake.apps // { default = flake.apps."helloyesod:exe:helloyesod"; };

        legacyPackages = pkgs;
      });

  # --- Flake Local Nix Configuration ----------------------------
  nixConfig = {
    extra-substituters = ["https://cache.iog.io"];
    extra-trusted-public-keys = ["hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="];
    allow-import-from-derivation = "true";
  };
}
