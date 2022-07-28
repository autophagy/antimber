{ ... }:

{
  imports = [
    ./polybar.nix
    ./redshift.nix
  ];

  services.picom.enable = true;
  services.keybase.enable = true;
}
