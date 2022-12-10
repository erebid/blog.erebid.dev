{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        src = ./.;
      in rec {
        packages = rec {
          static = pkgs.stdenv.mkDerivation {
            name = "samhzacom-static";
            inherit src;
            buildPhase = ''
              ${pkgs.hugo}/bin/hugo --minify
            '';
            installPhase = ''
              cp -r public $out
            '';
          };
        };

        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            hugo
          ];
        };
      });
}
