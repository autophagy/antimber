{ pkgs, common, ... }:

{
  services.polybar = {
    settings = {
      "bar/statusbar" = {
        monitor = "HDMI-0";
        modules-right = "vpn wlan cpu memory pulseaudio date";
      };

      "module/wlan" = {
        type = "internal/network";
        interface = "enp4s0";
        interval = 3.0;
        format-connected = "<label-connected>";
        label-connected = "%local_ip%";
        format-disconnected = "";
      };
    };
  };
}
