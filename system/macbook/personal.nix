{ config, pkgs, home, ... }:
{
  
  home = {
    packages = with pkgs; [ 
        # most used
        # _1password-gui
        # spotify
        # slack
        logseq
        iterm2
        docker

        # extra: nice to have
        # zotero
        # vlc
        # transmission
        # sublimetext4
        # plex

        # extra: dev
        fd
        httpie
        gh
    ];
  };

  programs =
    {

      git = {
        userEmail = "benjamin.starostka@gmail.com";
      };

      bat = {
        enable = true;
        config = {
          theme = "GitHub";
        };
      };

      vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
        ];
    };

    exa = {
      enable = true;
      enableAliases = true;
    };

  };

  services = {
  };
}