{ config, pkgs, ... }:

{
  programs.rofi = {
      enable = true;
      extraConfig = {
          modi = "drun";
      };
  };
}
