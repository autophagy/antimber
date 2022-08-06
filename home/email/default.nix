_:

{
  programs.mbsync.enable = true;
  programs.msmtp.enable = true;

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

  accounts.email = {
    accounts.immerok = {
      address = "mika@immerok.com";
      imap = {
        host = "imap.gmail.com";
        port = 993;
      };
      mbsync = {
        enable = true;
        create = "both";
        patterns = [ "*" "![Gmail]*" "[Gmail]/Sent Mail" "[Gmail]/Starred" "[Gmail]/All Mail" ];
        expunge = "both";
      };
      msmtp.enable = true;
      neomutt = {
        enable = true;
        extraConfig = ''
          color status cyan default
          color index cyan default "~N"
          color index red default "~D"
          set record="+[Gmail]/Sent Mail"
          set postponed="+[Gmail]/Drafts"
          set trash="+[Gmail]/Trash"
        '';
        extraMailboxes = [ "[Gmail]/Sent Mail" "[Gmail]/Trash" ];
      };
      primary = true;
      realName = "Mika Naylor";
      passwordCommand = "gpg -d --quiet $HOME/immer_cred.gpg";
      smtp = {
        host = "smtp.gmail.com";
        port = 465;
      };
      userName = "mika@immerok.com";
    };
  };
}
