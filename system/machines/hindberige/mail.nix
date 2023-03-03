{ config, pkgs, ... }:

let
  notification-script = pkgs.writeScriptBin "systemd-email" ''
    #! ${pkgs.runtimeShell} -e
    ${pkgs.msmtp}/bin/msmtp -a default --read-envelope-from --read-recipients <<ERRMAIL
    From: Grendel <notifications@autophagy.io>
    To: mail@autophagy.io
    Subject: systemd failure for $1
    Content-Transfer-Encoding: 8bit
    Content-Type: text/plain; charset=UTF-8

       .~~.   .~~.
      '. \ ' ' / .'
       .~ .~~~..~.
      : .~.'~'.~. :        _____ _       _ _           _
     ~ (   ) (   ) ~      |  |  |_|___ _| | |_ ___ ___|_|___ ___
    ( : '~'.~.'~' : )     |     | |   | . | . | -_|  _| | . | -_|
     ~ .~ (   ) ~. ~      |__|__|_|_|_|___|___|___|_| |_|_  |___|
      (  : '~' :  )                                     |___|
       '~ .~~~. ~'
           '~'

    $(${pkgs.systemd}/bin/systemctl status --full "$1")
    ERRMAIL
  '';
in
{
  sops.secrets.email = {
    sopsFile = ../../../secrets/hindberige/email.yaml;
    owner = "systemd-notify";
    key = "notifications";
  };

  programs.msmtp = {
    enable = true;
    accounts.default = {
      auth = true;
      tls = true;
      port = 465;
      tls_starttls = false;

      host = "mail.gandi.net";
      from = "notifications@autophagy.io";
      user = "notifications@autophagy.io";
      passwordeval = "cat ${config.sops.secrets.email.path}";
    };
  };

  users.users.systemd-notify = {
    group = "systemd-journal";
    description = "System user for systemd notification emails";
    isSystemUser = true;
  };

  systemd.services."systemd-notify@" = {
    description = "Trigger email for systemd failure for %i";
    serviceConfig = {
      Type = "oneshot";
      User = "systemd-notify";
      Group = "systemd-journal";
      ExecStart = "${notification-script}/bin/systemd-email %i";
    };
  };
}
