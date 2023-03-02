{ pkgs, ... }:

{
  home.packages = with pkgs; [ pure-prompt ];

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableSyntaxHighlighting = true;
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
    initExtra = ''
      autoload -U promptinit; promptinit
      PURE_PROMPT_SYMBOL="λ"
      prompt pure
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "gpg-agent" ];
    };
    sessionVariables = {
      EDITOR = "vim";
    };
  };
}
