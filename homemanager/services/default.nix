{ config, inputs, pkgs, ... }:

{
  imports = [ ./polybar.nix ];

  services.picom.enable = true;
  services.keybase.enable = true;
}
