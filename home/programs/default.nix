{ config, inputs, pkgs, ... }:

{
  imports = [
    ./git.nix
    ./i3.nix
    ./rofi.nix
  ];

  programs.home-manager.enable = true;
}
