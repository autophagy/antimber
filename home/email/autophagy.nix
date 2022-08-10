_:

{
  accounts.email = {
    accounts.autophagy = {
      realName = "Mika Naylor";
      passwordCommand = "gpg -d --quiet $HOME/auto_cred.gpg";
      address = "mail@autophagy.io";
      userName = "mail@autophagy.io";
      signature = {
        showSignature = "append";
        text = ''
          Mika Naylor
          Site Reliability Engineer
          immerok GmbH ✭ immerok.com
        '';
      };
      imap = {
        host = "mail.gandi.net";
        port = 993;
      };
      mbsync = {
        enable = true;
        create = "both";
        expunge = "both";
      };
      msmtp.enable = true;
      neomutt = {
        enable = true;
        mailboxName = "> autophagy";
        extraConfig = ''
          color status cyan default
          color index cyan default "~N"
          color index red default "~D"
        '';
        extraMailboxes = [
          "Inbox/github"
          "Inbox/mailing-lists/arch-announce"
          "Inbox/mailing-lists/nixos"
          "Inbox/mailing-lists/qutebrowser"
          "Inbox/mailing-lists/tla-plus"
          "Sifetha"
          "Sent"
          "Trash"
          "Junk"
        ];
      };
      smtp = {
        host = "mail.gandi.net";
        port = 465;
      };
    };
  };
}
