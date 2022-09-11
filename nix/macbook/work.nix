{ config, pkgs, home, ... }:
{

  home = {
    packages = with pkgs; [
        awscli2
        1password
        spotify
    ];
  };

  programs =
    {
      git = {
        userEmail = "benjamin.starostka@gmail.com";
      };
    };

  services = {
  };
}