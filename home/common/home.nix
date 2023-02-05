{ pkgs, ... }:

{
  _module.args.common = import ./common.nix;

  imports = [
    ./programs
    ./editors
    ./browsers
    ./services
    ./terminal
    ./email
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
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
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
    wget
    arandr
    ripgrep
    keepassxc
    scrot
    zathura
    bind
    htop
    sops
    jq
    just
    git-absorb
  ];
}
