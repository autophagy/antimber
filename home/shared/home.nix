{ pkgs, ... }:

{
  _module.args.common = import ./common.nix;

  imports = [
    ./base.nix
    ./programs
    ./terminal
    ./editors
  ];

  home.packages = with pkgs; [
    # Fonts
    nerd-fonts.inconsolata
    nerd-fonts.dejavu-sans-mono

    # Utilities
    wget
    ripgrep
    sops
    jq
    just
    git-absorb
    yubikey-manager

    # Devops
    kubectl
    kubectx
    awscli2
    cachix
    lnav
    obsidian
  ];
}
