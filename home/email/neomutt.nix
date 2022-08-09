{ pkgs, ... }:

{
  programs.neomutt = {
    enable = true;
    macros = [
      { map = [ "index" ]; key = "o"; action = "<shell-escape>mbsync -a -q &<enter>"; }
      { map = [ "index" "pager" ]; key = "B"; action = "<pipe-message> ${pkgs.urlscan}/bin/urlscan<Enter>"; }
      { map = [ "attach" "compose" ]; key = "B"; action = "<pipe-entry> ${pkgs.urlscan}/bin/urlscan<Enter>"; }
    ];
    binds = [
      { map = [ "index" "pager" ]; key = "<tab>"; action = "sync-mailbox"; }
      { map = [ "index" "pager" ]; key = "R"; action = "group-reply"; }
      { map = [ "index" "pager" ]; key = "<down>"; action = "sidebar-next"; }
      { map = [ "index" "pager" ]; key = "<up>"; action = "sidebar-prev"; }
      { map = [ "index" "pager" ]; key = "<right>"; action = "sidebar-open"; }
    ];
    sidebar = {
      enable = true;
      format = "%D %?S?[%N/%S]?";
    };
    vimKeys = true;
    sort = "threads";
    settings = {
      sort_aux = "reverse-last-date-received";
      wait_key = "no";
      timeout = "3";
      mail_check = "0";
      mail_check_stats = "yes";
    };
  };
}
