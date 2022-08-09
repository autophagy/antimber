_:

{
  accounts.email = {
    accounts.immerok = {
      primary = true;
      realName = "Mika Naylor";
      passwordCommand = "gpg -d --quiet $HOME/immer_cred.gpg";
      address = "mika@immerok.com";
      userName = "mika@immerok.com";
      signature = {
        showSignature = "append";
        text = ''
          Mika Naylor
          Site Reliability Engineer
          immerok GmbH ✭ immerok.com
        '';
      };
      imap = {
        host = "imap.gmail.com";
        port = 993;
      };
      mbsync = {
        enable = true;
        create = "both";
        patterns = [ "*" "![Gmail]*" "[Gmail]/Sent Mail" "[Gmail]/Starred" "[Gmail]/All Mail" "[Gmail]/Spam" "[Gmail]/Trash" ];
        expunge = "both";
      };
      msmtp.enable = true;
      neomutt = {
        enable = true;
        mailboxName = "> immerok";
        extraConfig = ''
          color status magenta default
          color index magenta default "~N"
          color index red default "~D"
          set record="+[Gmail]/Sent Mail"
          set postponed="+[Gmail]/Drafts"
          set trash="+[Gmail]/Trash"
        '';
        extraMailboxes = [ "[Gmail]/Sent Mail" "[Gmail]/Trash" "[Gmail]/Spam" ];
      };
      smtp = {
        host = "smtp.gmail.com";
        port = 465;
      };
    };
  };
}
