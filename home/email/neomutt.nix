_:

{
  programs.neomutt = {
    enable = true;
    macros = [
      { map = [ "index" ]; key = "o"; action = "<shell-escape>mbsync -a -q &<enter>"; }
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
    extraConfig = ''
      set sort_aux = reverse-last-date-received
      set wait_key = no
    '';
  };
}
