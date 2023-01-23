{ pkgs, ... }:
let
  fmt = pkgs.formats.json { };
in
{
  home.packages = with pkgs; [ discord ];

  xdg.configFile."discord/settings.json".source =
    fmt.generate "discord.json" {
      SKIP_HOST_UPDATE = true;
    };
}
