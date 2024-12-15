{
  pkgs,
  common,
  lib,
  rootPath,
  hostName,
  ...
}:

let
  mod = "Mod4";
  backgroundImage = rootPath + "/static/backgrounds/${hostName}.jpg";
  lockImage = rootPath + "/static/backgrounds/${hostName}-lock.png";
in
{
  programs.swaylock = {
    enable = true;
  };

  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;

    config = {
      modifier = "Mod4";
      menu = "rofi -show drun";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      workspaceAutoBackAndForth = true;
      defaultWorkspace = "workspace number 1";
      bars = [ { command = "${pkgs.waybar}/bin/waybar"; } ];

      colors = {
        focused = {
          inherit (common.colours) background;
          border = common.colours.foreground;
          childBorder = common.colours.foreground;
          indicator = common.colours.foreground;
          text = common.colours.foreground;
        };
      };

      output = {
        "*" = {
          bg = "${backgroundImage} fill";
        };
      };

      gaps = {
        inner = 5;
        outer = 0;
        smartGaps = true;
        smartBorders = "on";
      };

      assigns = {
        "2" = [
          { app_id = "firefox"; }
          { class = "qutebrowser"; }
          { class = "Chromium-browser"; }
        ];
        "9" = [ { class = "discord"; } ];
        "10" = [ { class = "slack"; } ];
      };

      floating = {
        border = 1;

        criteria = [
          { class = "Pavucontrol"; }
          { class = "KeePassXC"; }
          { class = "zoom"; }
        ];
      };

      keybindings = lib.mkOptionDefault {
        "XF86MonBrightnessUp" = "exec light -A 2";
        "XF86MonBrightnessDown" = "exec light -U 2";
        "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioMicMute" = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle";

        "Print" = "exec --no-startup-id grim -g \"$(slurp)\"";

        "${mod}+Shift+o" = "exec --no-startup-id swaylock -i ${lockImage}";

        "${mod}+m" = "move workspace to output right";
        "${mod}+Shift+m" = "move workspace to output left";

        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";
      };

      window.commands = [
        {
          command = "border pixel 1";
          criteria = {
            class = "^.*";
          };
        }
      ];
    };
  };
}
