{ config, inputs, pkgs, ... }:

{
  imports = [
    ./programs
    ./editors
    ./browsers
    ./services
    ./terminal
  ];

  home.username = "mika";
  home.homeDirectory = "/home/mika";
  home.stateVersion = "22.05";

  nixpkgs.config.allowUnfree = true;
  xsession.enable = true;
  fonts.fontconfig.enable = true;

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/about" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/unknown" = "org.qutebrowser.qutebrowser.desktop";
      "application/pdf" = "zathura.desktop";
    };
  };

  home.packages = with pkgs; [
    # Fonts
    (nerdfonts.override { fonts = [ "Inconsolata" "DejaVuSansMono" ]; })
    symbola

    # Browsers
    firefox
    qutebrowser

    # Communication
    irssi
    slack
    discord
    zoom-us

    # Media
    gimp
    mpv
    pavucontrol
    spotify
    obs-studio

    # Devops
    kubectl
    kubectx
    awscli2
    fluxcd
    minikube

    # Languages/Language Tools
    nixpkgs-fmt

    # Utilities
    wget
    bat
    arandr
    ripgrep
    keepassxc
    scrot
    zathura
  ];
}
