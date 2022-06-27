{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
in
{
  home.packages = with pkgs; [ feh ];

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = {
      modifier = "Mod4";
      menu = "rofi -show drun";
      terminal = "${pkgs.rxvt-unicode}/bin/urxvt";
      startup = [
        { command = "${pkgs.feh}/bin/feh --bg-fill ~/.background-image.jpg"; }
      ];
      gaps = {
        inner = 5;
        outer = 0;
        smartGaps = true;
        smartBorders = "on";
      };
    };
  };
}
