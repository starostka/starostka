{ config, pkgs, home, ... }:
{

  # core components: will always be installed
  home = {
    # Specify packages not explicitly configured below
    packages = with pkgs; [
      # most important
      neovim
      watchexec
      tailscale
      syncthing

      # extra
      hyperfine
      imagemagick
      jq
      pandoc
      ripgrep
      tree
      tree-sitter
      youtube-dl
     ];
  };

  programs = {

    git = {
        userName = "Starostka";
        
        ignores = [
            ".*.swp"
            ".bundle"
            "vendor/bundle"
            ".DS_Store"
            "Icon"
            "*.pyc"
            ".direnv"
        ];
      };

    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };

  };

  services = {
  };

}