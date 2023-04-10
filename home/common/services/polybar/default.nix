{ pkgs, common, ... }:

let
  vpnstatusScript = pkgs.callPackage ./scripts/vpnstatus.nix { };
in
{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
      pulseSupport = true;
    };

    settings = {
      "bar/statusbar" = {
        width = "100%";
        height = 30;
        radius = 0.0;
        fixed-center = true;
        inherit (common.colours) background;
        inherit (common.colours) foreground;
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
      };

      "module/i3" = {
        type = "internal/i3";
        format = "∀ <label-state> <label-mode>";
        index-sort = true;
        wrapping-scroll = true;
        strip-wsnumbers = true;
        pin-workspaces = false;
        label-unfocused-padding = 1;
        label-unfocused-foreground = common.colours.bgFgBlended;
        label-focused-foreground = common.colours.foreground;
        label-focused-padding = 1;
        label-urgent-foreground = "#29615A";
        label-urgent-padding = 1;
        label-visible-padding = 1;
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        format-volume = "<label-volume>";
        label-muted = "--%";
        label-volume = "%percentage%%";
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

      "module/vpn" = {
        type = "custom/script";
        interval = 5.0;
        exec = "${vpnstatusScript}/bin/vpnstatus";
      };

    };

    script = "polybar statusbar &";
  };
}
