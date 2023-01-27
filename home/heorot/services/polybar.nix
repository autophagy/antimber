{ pkgs, common, ... }:

{
  services.polybar = {
    settings = {
      "bar/statusbar" = {
        monitor = "eDP-1";
        modules-right = "vpn wlan battery cpu memory pulseaudio date";
      };

      "module/wlan" = {
        type = "internal/network";
        interface = "wlp0s20f3";
        interval = 3.0;
        format-connected = "<label-connected>";
        label-connected = "%local_ip%";
        format-disconnected = "";
      };

      "module/battery" = {
        type = "internal/battery";
        battery = "BAT0";
        adapter = "AC";
        full-at = 99;
        low-at = 10;
        format-discharging = "BAT <label-discharging>";
        format-charging = "BAT +<label-charging>";
        format-low = "%{F${common.colours.alert}}BAT <label-low>%{F-}";
        label-full = "";
      };
    };
  };
}
