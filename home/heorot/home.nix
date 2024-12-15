{ pkgs, ... }:

{
  imports = [
    ./editors
    ./terminal
    ./virtualisation
    ./services
    ./programs
    ./wayland
  ];

  home.packages = with pkgs; [
    # Media
    obs-studio

    # Devops
    kubectl
    kubectx
    awscli2
    minikube

    # Utilities
    lnav
    cachix
    obsidian
    grim
    slurp
  ];

}
