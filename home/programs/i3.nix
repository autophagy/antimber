{ lib, pkgs, config, ... }:

let
  mod = "Mod4";
  common = import ../common.nix;
in
{
  home.packages = with pkgs; [ feh i3lock ];

  home.file = {
    backgroundImage = {
      source = ../../static/background-image.jpg;
      target = ".config/background.jpg";
    };

    lockImage = {
      source = ../../static/lock.png;
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
      ];

      gaps = {
        inner = 5;
        outer = 0;
        smartGaps = true;
        smartBorders = "on";
      };

      assigns = {
        "2" = [{ class = "firefox"; } { class = "qutebrowser"; }];
        "3" = [{ class = "code"; }];
        "9" = [{ class = "discord"; }];
        "10" = [{ class = "slack"; }];
      };

      floating.criteria = [
        { class = "Pavucontrol"; }
        { class = "Keepassx2"; }
        { class = "zoom"; }
      ];

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
      };
    };
  };
}
