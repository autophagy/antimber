{ pkgs, common, ... }:

let
  vpnStatusScript = pkgs.callPackage ../../common/services/polybar/scripts/vpnstatus.nix { };
  style = import ./waybar-style.nix { inherit common; };
in
{
  programs.waybar = {
    inherit style;

    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        output = [
          "eDP-1"
        ];
        modules-left = [
          "sway/workspaces"
          "sway/mode"
        ];
        modules-center = [
        ];
        modules-right = [
          "custom/vpn"
          "custom/separator"
          "network"
          "custom/separator"
          "pulseaudio"
          "custom/separator"
          "cpu"
          "custom/separator"
          "memory"
          "custom/separator"
          "battery"
          "custom/separator"
          "clock"
        ];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };
        "clock" = {
          interval = 5;
          tooltip = false;
          format = "{:%H.%M // %d %b %Y}";
        };
        "battery" = {
          format = "BAT {capacity}%";
          format-charging = "BAT +{capacity}%";
          format-plugged = "BAT +{capacity}%";
          states = {
            warning = 30;
            critical = 15;
          };
        };
        "network" = {
          format-wifi = "{ipaddr}";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (no ip) ";
          format-disconnected = "off ";
          format-alt = "{ifname} = {ipaddr}/{cidr} ";
        };
        "cpu" = {
          format = "CPU {usage}%";
        };
        "memory" = {
          format = "MEM {}%";
        };
        "custom/vpn" = {
          exec = "${vpnStatusScript}/bin/vpnstatus";
          interval = 5;
          format = "{}  ";
        };
        "custom/separator" = {
          format = "|";
          interval = "once";
          tooltip = false;
        };
      };
    };
  };
}
