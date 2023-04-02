{ pkgs, ... }:

{
  imports = [
    ./services
    ./programs
  ];

  home.packages = with pkgs; [
    conda
    blender
  ];
}
