{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ pure-prompt ];

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
      vim = "nvim";
      g = "git";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    initExtra = ''
      autoload -U promptinit; promptinit
      prompt pure
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
