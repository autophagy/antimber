{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ pure-prompt ];

  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -l";
      g = "git";
      k = "kubectl";
      kctx = "kubectx";
      kns = "kubens";
      mail = "neomutt";
      wttr = "curl v2.wttr.in";
    };
    history = {
      size = 10000;
      path = "$HOME/.zsh_history";
      ignoreSpace = true;
    };
    initContent = ''
      autoload -U promptinit; promptinit
      PURE_PROMPT_SYMBOL="λ"
      PURE_GIT_PULL=0
      prompt pure
      clear
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "gpg-agent" ];
    };
    sessionVariables = {
      EDITOR = "hx";
    };
  };
}
