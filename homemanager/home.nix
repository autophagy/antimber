{ config, inputs, pkgs, ... }:

{
  imports = [
    ./git.nix
    ./vim.nix
    ./qutebrowser.nix
    ./rofi.nix
    ./i3.nix
    ./polybar.nix
    ./terminal.nix
  ];

  home.username = "mika";
  home.homeDirectory = "/home/mika";
  home.stateVersion = "22.05";

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  xsession.enable = true;
  services.picom.enable = true;
  programs.vscode.enable = true;
  fonts.fontconfig.enable = true;
  services.keybase.enable = true;

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