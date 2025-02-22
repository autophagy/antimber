{ common, ... }:
let
  font-size = 10;
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding = {
          x = font-size * 2;
          y = font-size * 2;
        };
        decorations = "Full";
        decorations_theme_variant = "Dark";
      };
      font = {
        normal.family = "Inconsolata";
        bold.family = "Inconsolata";
        italic.family = "Inconsolata";
        bold_italic.family = "Inconsolata";
        size = font-size;
      };
      colors = {
        primary = {
          inherit (common.colours) background;
          inherit (common.colours) foreground;
        };
        normal = {
          black = "#282828";
          red = "#cc241d";
          green = "#98971a";
          yellow = "#d79921";
          blue = "#458588";
          magenta = "#b16286";
          cyan = "#689d6a";
          white = "#a89984";
        };

        bright = {
          black = "#928374";
          red = "#fb4934";
          green = "#b8bb26";
          yellow = "#fabd2f";
          blue = "#83a598";
          magenta = "#d3869b";
          cyan = "#8ec07c";
          white = "#ebdbb2";
        };
      };
    };
  };
}
