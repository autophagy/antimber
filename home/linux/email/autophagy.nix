{ pkgs, config, ... }:
{
  accounts.email = {
    accounts.autophagy = {
      primary = true;
      realName = "Mika Naylor";
      passwordCommand = "${pkgs.sops}/bin/sops --decrypt --extract \"['autophagy']\" ~/${config.home.file.mail.target}";
      address = "mail@autophagy.io";
      userName = "mail@autophagy.io";
      signature = {
        showSignature = "append";
        text = ''
          Mika Naylor
          autophagy.io
        '';
      };
      imap = {
        host = "imap.fastmail.com";
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
          "newsletters"
          "github"
          "mailing-lists/arch-announce"
          "mailing-lists/nixos"
          "mailing-lists/qutebrowser"
          "mailing-lists/tla-plus"
          "Sifetha"
          "Sent"
          "Trash"
          "Junk"
        ];
      };
      smtp = {
        host = "smtp.fastmail.com";
        port = 465;
      };
      gpg = {
        signByDefault = true;
      };
    };
  };
}
