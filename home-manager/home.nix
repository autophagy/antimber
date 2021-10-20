{ config, pkgs, ... }:

{
  imports = [ ./zsh.nix ./git.nix ./nvim.nix ];

  programs.home-manager.enable = true;
  home.username = "mika";
  home.homeDirectory = "/home/mika";
  home.stateVersion = "21.05";
}
