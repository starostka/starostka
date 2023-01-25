{
  description = "Starostka's Public Repository";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.flake-compat.url = "github:edolstra/flake-compat";
  inputs.flake-compat.flake = false;

  outputs = { self, nixpkgs, flake-utils, flake-compat }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
    in
    {
      # packages = {
      #   default = Nil;
      # };

      devShells.default = pkgs.mkShell {
        buildInputs = [
          pkgs.git
          pkgs.nixFlakes
          pkgs.coreutils
        ];
        packages = [

          # Essentials toolchain
          pkgs.bashInteractive
          pkgs.comma
          pkgs.direnv

          # Python toolchain
          pkgs.pre-commit
          pkgs.black
          pkgs.isort
          pkgs.mypy
          pkgs.sphinx

          # Haskell toolchain
          pkgs.haskellPackages.ghcup
          pkgs.haskellPackages.cabal
        ];

        shellHook = ''
        # define environment variables
        git_root=$(${pkgs.git}/bin/git rev-parse --show-toplevel)

        echo "Welcome to Starostka"
        '';
      };
    });
}