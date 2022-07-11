{ ... }:
let
  common = import ../common.nix;
in
{
  programs.urxvt = {
    enable = true;
    scroll.bar.enable = false;
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

      "foreground" = common.colours.foreground;
      "background" = common.colours.background;
      "cursorColor" = common.colours.foreground;

      # black
      "color0" = "#282828";
      "color8" = "#928374";

      # red
      "color1" = "#cc241d";
      "color9" = "#fb4934";

      # green
      "color2" = "#98971a";
      "color10" = "#b8bb26";

      # yellow
      "color3" = "#d79921";
      "color11" = "#fabd2f";

      # blue
      "color4" = "#458588";
      "color12" = "#83a598";

      # magenta
      "color5" = "#b16286";
      "color13" = "#d3869b";

      # cyan
      "color6" = "#689d6a";
      "color14" = "#8ec07c";

      # white
      "color7" = "#a89984";
      "color15" = "#ebdbb2";
    };
  };
}
