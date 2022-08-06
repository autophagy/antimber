_:

{
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
      signature = {
        showSignature = "append";
        text = ''
          Mika Naylor
          Site Reliability Engineer
          immerok GmbH ✭ immerok.com
        '';
      };
    };
  };
}
