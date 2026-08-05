{ pkgs, lib, ... }:

{
  imports = [
    ./services
    ./programs
  ];

  home.packages = with pkgs; [
    conda
    blender
  ];

  services.picom.enable = lib.mkForce false;
}
