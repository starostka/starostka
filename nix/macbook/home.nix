{ config, pkgs, home, lib, ... }:
with lib;
let
  host_env = builtins.getEnv "HOSTENV";
  username = builtins.getEnv "USER";
  home_directory = builtins.getEnv("HOME");
in
{

  # Assertion check
  # username != "";
  # home_directory != "";

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = username;
  home.homeDirectory = home_directory;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # Allow proprietary software
  nixpkgs.config.allowUnfree = true;
  # Allow unsupported software
  nixpkgs.config.allowUnsupportedSystem = true;
  # Allow broken packages
  nixpkgs.config.allowBroken = true;

  # Load the right host configuration
  imports = if host_env != ""
            then if host_env == "personal" then
              lib.info "loading PERSONAL home manager environment"
                [ ./core.nix ./personal.nix ]
                else
                  if host_env == "work" then
                    lib.info "loading WORK home manager environment"
                      [ ./core.nix ./work.nix ]
                  else
                    lib.warn "HOSTENV is not one of 'personal' or 'work', ONLY core home environment will be available!" []
            else
              lib.warn "HOSTENV not specified, nothing will be installed!" [];
}