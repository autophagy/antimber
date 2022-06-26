{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    extraConfig.modi = "drun";
    theme = "gruvbox-light-soft";
  };
}
