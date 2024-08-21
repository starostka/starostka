{
  description = "Starostka Public";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    workspace.url = "github:starostka/workspace";

    flake-parts.url = "github:hercules-ci/flake-parts";

    systems.url = "github:nix-systems/default";

    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";

    process-compose-flake.url = "github:Platonic-Systems/process-compose-flake";

    services-flake.url = "github:juspay/services-flake";

    mission-control.url = "github:Platonic-Systems/mission-control";

    treefmt-nix.url = "github:numtide/treefmt-nix";

    flake-root.url = "github:srid/flake-root";
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
    workspace,
    flake-parts,
    ...
  }:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import inputs.systems;
      imports = [
        inputs.devshell.flakeModule
        inputs.process-compose-flake.flakeModule
        inputs.mission-control.flakeModule
        inputs.treefmt-nix.flakeModule
        inputs.flake-root.flakeModule
      ];
      perSystem = {
        # self',
        pkgs,
        lib,
        config,
        ...
      }: {
        devshells.default = {
          env = [
            {
              name = "GOROOT";
              value = pkgs.go + "/share/go";
            }
            {
              name = "LD_LIBRARY_PATH";
              value = "$DEVSHELL_DIR/lib";
            }
          ];

          packages = with lib;
            mkMerge [
              [
                pkgs.elixir
                pkgs.ncdu
                # pkgs.nodejs
              ]
              (mkIf pkgs.stdenv.isLinux [
                pkgs.gcc
              ])
              (mkIf pkgs.stdenv.isDarwin [
                pkgs.darwin.cctools
                # (with pkgs.darwin.apple_sdk.frameworks; [Accelerate Security IOKit CoreFoundation MetalKit])
              ])
            ];

          commands = [
            {
              category = "development";
              package = pkgs.nodejs;
            }
          ];
        };

        # mission-control.scripts = {
        #   docs = {
        #     description = "Start Hoogle server for project dependencies";
        #     exec = ''
        #       echo http://127.0.0.1:8888
        #       hoogle serve -p 8888 --local
        #     '';
        #     category = "Dev Tools";
        #   };
        # };

        treefmt.config = {
          inherit (config.flake-root) projectRootFile;
          package = pkgs.treefmt;
          programs = {
            alejandra.enable = true;
            deadnix.enable = true;
            gofumpt.enable = true;
            prettier.enable = true;
            statix.enable = true;
          };
          settings.formatter.prettier.options = ["--tab-width" "4"];
        };

        process-compose."default" = {
          imports = [
            inputs.services-flake.processComposeModules.default
          ];
          services.postgres."pg1" = {
            enable = true;
            # socketDir = "/tmp/postgresql";
            initialScript.before = ''
              CREATE ROLE postgres WITH LOGIN PASSWORD 'postgres';
              ALTER ROLE postgres WITH SUPERUSER CREATEDB CREATEROLE REPLICATION;
            '';
          };
          services.pgadmin."pgad1" = {
            enable = true;
            initialEmail = "benjamin@starostka.io";
            initialPassword = "password";
          };
        };
      };
    };
}
