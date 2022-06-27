{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userEmail = "mail@autophagy.io";
    userName = "Mika Naylor";
    extraConfig = {
      rebase = { autosquash = true; };
      user = { signingKey = "F7236FBA"; };
      credential = { helper = "cache --timeout=3600"; };
      core = { editor = "nvim"; };
      push = { default = "simple"; };
      pull = { rebase = false; };
    };
    aliases = {
      a = "add";
      aa = "add -A";
      aip = "add -ip";
      b = "branch";
      bd = "branch -d";
      co = "checkout";
      cob = "checkout -b";
      cam = "commit -am";
      cm = "commit -m";
      ca = "commit --amend";
      cane = "commit --amend --no-edit";
      cf = "commit --fixup";
      cfh = "commit --fixup HEAD";
      cp = "cherry-pick";
      d = "diff";
      dc = "diff --cached";
      ds = "diff --staged";
      f = "fetch --prune";
      fa = "fetch --all --prune";
      fo = "fetch origin --prune";
      g = "grep -n --break";
      l = "!sh -c 'git log --pretty=format:\"%Cred%h%Creset -%C(auto)%d%Creset %s %C(white)(%cr)%Creset %C(yellow)%ae%Creset\" develop.. | cat -n;echo'";
      lc = "!sh -c 'git log --pretty=format:\"%Cred%h%Creset -%C(auto)%d%Creset %s %C(white)(%cr)%Creset %C(yellow)%ae%Creset\" --graph'";
      la = "!sh -c 'git log --pretty=format:\"%Cred%h%Creset -%C(auto)%d%Creset %s %C(white)(%cr)%Creset %C(yellow)%ae%Creset\" --graph --all'";
      lr = "!sh -c 'echo \"\" & git log --pretty=format:\"%Cred%h%Creset -%C(auto)%d%Creset %s %C(white)(%cr)%Creset %C(yellow)%ae%Creset\" -20 --graph --all | cat -n;echo & echo \"\"'";
      lo = "!sh -c 'git log --oneline --abbrev-commit --all --graph --decorate --color'";
      m = "merge";
      mnf = "merge --no-ff";
      ph = "push";
      pho = "push origin";
      phu = "!sh -c 'git push -u origin $(git rev-parse --abbrev-ref HEAD)'";
      phf = "push --force-with-lease";
      phoh = "push origin head";
      phod = "push origin develop";
      pl = "pull";
      plo = "pull origin";
      plod = "pull origin develop";
      pr = "pull --rebase";
      pro = "pull --rebase origin";
      prod = "pull --rebase origin develop";
      r = "rebase";
      ra = "rebase --abort";
      rc = "rebase --continue";
      ri = "rebase --interactive --autosquash";
      ro = "rebase --onto";
      rs = "rebase --skip";
      rl = "reflog --pretty='%cd %h %gd %gs'";
      rt = "reset";
      rth = "reset --hard";
      rts = "reset --soft";
      s = "status";
      sh = "!sh -c 'if [[ $0  =~ ^[0-9]+$ ]]; then LINE=$(($0-1)); else LINE=0; fi; git show HEAD~$(($LINE))'";
      ctags = "!.git/hooks/ctag";
    };
  };
}
