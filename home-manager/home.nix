{ config, pkgs, ... }:

{
  imports = [ ./zsh.nix ./git.nix ./nvim.nix ./qutebrowser.nix ];

  programs.home-manager.enable = true;
  home.username = "mika";
  home.homeDirectory = "/home/mika";
  home.stateVersion = "21.05";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    wget
    bat
    firefox
    rxvt_unicode
    keepassxc
    dmenu
    xmobar
    pavucontrol
    rofi
    zoom-us
    gimp
    slack
    kubectl kubectx
    awscli2 azure-cli google-cloud-sdk
    terraform
    minikube
    arandr
    ripgrep
    spotify
    light
  ];
}
