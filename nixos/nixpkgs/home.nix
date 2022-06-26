{ config, lib, pkgs, ... }:

{
  imports = [ ./git.nix ./nvim.nix ./qutebrowser.nix ./rofi.nix ./i3.nix ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "mika";
  home.homeDirectory = "/home/mika";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Enable unfree packages
  nixpkgs.config.allowUnfree = true;

  xsession.enable = true;

  services.picom.enable = true;

  programs.vscode.enable = true;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # Fonts
    (nerdfonts.override { fonts = [ "Inconsolata" "DejaVuSansMono" ]; })
    symbola

    # Browsers
    firefox qutebrowser

    # Communication
    irssi slack discord zoom-us

    # Media
    gimp mpv pavucontrol spotify

    # Devops
    kubectl kubectx awscli2

    # Utilities
    wget bat arandr ripgrep keepassxc fzf
  ];
}
