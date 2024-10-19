{
  description = "Starostka's Public Repository (Monorepo)";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nix-filter.url = "github:numtide/nix-filter";
    systems.url = "github:nix-systems/default";
  };
  nixConfig = {
    extra-trusted-public-keys = [
      "cache.thalheim.io-1:R7msbosLEZKrxk/lKxf9BTjOOH7Ax3H0Qj0/6wiHOgc="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
    extra-substituters = [
      "https://cache.thalheim.io"
      "https://devenv.cachix.org"
      "https://cuda-maintainers.cachix.org"
    ];
  };

  outputs = inputs @ {
    nixpkgs,
    flake-parts,
    nix-filter,
    ...
  }:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import inputs.systems;
      perSystem = {
        # self',
        pkgs,
        lib,
        config,
        ...
      }: {
        devShells.default = pkgs.callPackage ./nix/dev.nix {};
      };
    };
}
