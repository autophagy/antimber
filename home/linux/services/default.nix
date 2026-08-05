{ ... }:

{
  imports = [
    ./polybar
    ./redshift.nix
  ];

  services.picom = {
    enable = true;
    vSync = true;
  };
  services.keybase.enable = true;
}
