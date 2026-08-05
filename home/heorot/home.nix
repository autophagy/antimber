{ pkgs, ... }:

{
  imports = [
    ./virtualisation
    ./services
    ./programs
    ./wayland
  ];

  home.packages = with pkgs; [
    # Media
    obs-studio

    # Wayland utilities
    grim
    slurp
  ];
}
