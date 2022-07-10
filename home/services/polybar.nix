{ config, lib, pkgs, ... }:

let
  common = import ../common.nix;
in
{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3GapsSupport = true;
      pulseSupport = true;
    };

    settings = {
      "bar/statusbar" = {
        monitor = "eDP-1";
        width = "100%";
        height = 30;
        radius = 0.0;
        fixed-center = true;
        background = common.colours.background;
        foreground = common.colours.foreground;
        line-size = 3;
        line-color = "#F00";
        border-size = 0;
        border-color = "#00000000";
        padding-left = 2;
        padding-right = 2;
        separator = "|";
        module-margin-left = 1;
        module-margin-right = 1;
        font-0 = "Inconsolata:pixelsize=9;2";
        modules-left = "i3";
        modules-right = "wlan battery cpu memory pulseaudio date";
      };

      "module/i3" = {
        type = "internal/i3";
        format = "∀ <label-state> <label-mode>";
        index-sort = true;
        wrapping-scroll = true;
        strip-wsnumbers = true;
        pin-workspaces = true;
        label-unfocused-padding = 1;
        label-unfocused-foreground = common.colours.bgFgBlended;
        label-focused-foreground = common.colours.foreground;
        label-focused-padding = 1;
        label-urgent-foreground = "#29615A";
        label-urgent-padding = 1;
        label-visible-padding = 1;
      };

      "module/wlan" = {
        type = "internal/network";
        interface = "wlp0s20f3";
        interval = 3.0;
        format-connected = "<label-connected>";
        label-connected = "%local_ip%";
        format-disconnected = "";
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        format-volume = "<label-volume>";
        label-muted = "--%";
        label-volume = "%percentage%%";
      };

      "module/battery" = {
        type = "internal/battery";
        battery = "BAT0";
        adapter = "AC";
        format-discharging = "BAT <label-discharging>";
        format-charging = "BAT +<label-charging>";
        label-full = "";
      };

      "module/cpu" = {
        type = "internal/cpu";
        label = "CPU %percentage%%";
      };

      "module/memory" = {
        type = "internal/memory";
        interval = 3;
        label = "MEM %percentage_used%%";
      };

      "module/date" = {
        type = "internal/date";
        interval = 1.0;
        date = "%d %b %Y";
        time = "%H.%M";
        label = "%date% // %time%";
      };

    };

    script = "polybar statusbar &";
  };
}
