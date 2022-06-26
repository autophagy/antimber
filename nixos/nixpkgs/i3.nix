{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
in {
    home.packages = with pkgs; [ feh ];
    programs.urxvt = {
        enable = true;
        keybindings = {
            "Shift-Control-C" = "eval:selection_to_clipboard";
            "Shift-Control-V" = "eval:paste_clipboard";
        };
        fonts = [
            "xft:Inconsolata Nerd Font:size=12:antialias=true:style=Regular"
            "xft:DejaVuSansMono Nerd Font Mono:style=Book:size=10"
            "xft:Symbola:style=Regular:size=12"
        ];
        extraConfig = {
            "internalBorder" = "25";

            "foreground" =   "#ebdbb2";
            "background" =   "#282828";
            "cursorColor" =  "#ebdbb2";

            # black
            "color0" =       "#282828";
            "color8" =       "#928374";

            # red
            "color1" =       "#cc241d";
            "color9" =       "#fb4934";

            # green
            "color2" =       "#98971a";
            "color10" =      "#b8bb26";

            # yellow
            "color3" =       "#d79921";
            "color11" =      "#fabd2f";

            # blue
            "color4" =       "#458588";
            "color12" =      "#83a598";

            # magenta
            "color5" =       "#b16286";
            "color13" =      "#d3869b";

            # cyan
            "color6" =       "#689d6a";
            "color14" =      "#8ec07c";

            # white
            "color7" =       "#a89984";
            "color15" =      "#ebdbb2";
        };
    };

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
