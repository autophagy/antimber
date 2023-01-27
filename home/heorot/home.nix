{ pkgs, ... }:

{
  imports = [
    ./editors
    ./terminal
    ./virtualisation
    ./services
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
  ];
}
