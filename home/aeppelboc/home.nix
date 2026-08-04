{
  config,
  lib,
  pkgs,
  ...
}:

{
  _module.args.common = import ../common/common.nix;

  imports = [
    ../common/base.nix
    ../common/programs/git.nix
    ../common/programs/bat.nix
    ../common/terminal/zsh.nix
    ../common/terminal/fzf.nix
    ../common/editors/neovim
    ../heorot/editors/neovim
    ../heorot/editors/helix
    ../heorot/terminal/direnv.nix
  ];

  home.homeDirectory = "/Users/mika";

  home.packages = with pkgs; [
    nerd-fonts.inconsolata
    nerd-fonts.dejavu-sans-mono
    wget
    ripgrep
    sops
    jq
    just
    git-absorb
    kubectl
    kubectx
    awscli2
    cachix
    lnav
    obsidian
  ];

  programs = {
    gh.enable = true;
    home-manager.enable = true;
    git = {
      signing = {
        key = lib.mkForce "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
        signByDefault = true;
      };
      settings.gpg.format = "ssh";
    };
  };
}
