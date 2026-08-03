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

  home = {
    username = "mika";
    homeDirectory = "/home/mika";
    stateVersion = "22.05";

    packages = with pkgs; [
      # Fonts
      nerd-fonts.inconsolata
      nerd-fonts.dejavu-sans-mono

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
      yubikey-manager
    ];

  };

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
}
