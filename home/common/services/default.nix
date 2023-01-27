{ ... }:

{
  imports = [
    ./polybar
    ./redshift.nix
  ];

  services.picom.enable = true;
  services.keybase.enable = true;
  services.syncthing.enable = true;
}
