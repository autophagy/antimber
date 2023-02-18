{ pkgs, ... }:

{
  imports = [
    ./editors
    ./terminal
    ./virtualisation
    ./services
    ./programs
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
  ];
}
