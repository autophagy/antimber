{
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ../shared/home.nix
    ./programs
    ./terminal
    ./browsers
    ./services
    ./email
  ];

  home.homeDirectory = lib.mkDefault "/home/mika";

  home.packages = with pkgs; [
    # Browsers
    chromium

    # Communication
    slack
    zoom-us

    # Media
    gimp
    mpv
    pavucontrol
    spotify
    jellyfin-media-player

    # Utilities
    arandr
    scrot
    keepassxc
    zathura
    bind
    htop
  ];

  xsession.enable = true;
  fonts.fontconfig.enable = true;

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
      "application/pdf" = "zathura.desktop";
    };
  };
}
