{ lib, ... }:

{
  services.redshift.enable = lib.mkForce false;

  services.gammastep = {
    enable = true;
    latitude = 52.520008;
    longitude = 13.404954;
    temperature = {
      day = 6500;
      night = 3700;
    };
  };
}
