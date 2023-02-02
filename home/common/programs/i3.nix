{ lib, pkgs, config, rootPath, common, hostName, ... }:

let
  mod = "Mod4";
in
{
  home.packages = with pkgs; [ feh i3lock ];

  home.file = {
    backgroundImage = {
      source = rootPath + "/static/backgrounds/${hostName}.jpg";
      target = ".config/background.jpg";
    };

    lockImage = {
      source = rootPath + "/static/backgrounds/${hostName}-lock.png";
      target = ".config/lock.png";
    };
  };

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = {
      modifier = "Mod4";
      menu = "rofi -show drun";
      terminal = "${pkgs.rxvt-unicode}/bin/urxvt";
      workspaceAutoBackAndForth = true;
      defaultWorkspace = "workspace number 1";
      bars = [ ];

      colors = {
        focused = {
          inherit (common.colours) background;
          border = common.colours.foreground;
          childBorder = common.colours.foreground;
          indicator = common.colours.foreground;
          text = common.colours.foreground;
        };
      };

      startup = [
        { command = "${pkgs.feh}/bin/feh --bg-fill ${config.home.homeDirectory}/${config.home.file.backgroundImage.target}"; }
        { command = "${pkgs.autorandr}/bin/autorandr -c"; }
      ];

      gaps = {
        inner = 5;
        outer = 0;
        smartGaps = true;
        smartBorders = "on";
      };

      assigns = {
        "2" = [{ class = "firefox"; } { class = "qutebrowser"; } { class = "chromium-browser"; }];
        "3" = [{ class = "code"; }];
        "9" = [{ class = "discord"; }];
        "10" = [{ class = "slack"; }];
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

        "Print" = "exec --no-startup-id scrot ~/images/screenshots/%b%d::%H%M%S.png";
        "Shift+Print" = "exec --no-startup-id scrot -s ~/images/screenshots/%b%d::%H%M%S.png";

        "${mod}+Shift+o" = "exec --no-startup-id i3lock -i ${config.home.homeDirectory}/${config.home.file.lockImage.target}";

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
        { command = "border pixel 1"; criteria = { class = "^.*"; }; }
      ];
    };
  };
}
