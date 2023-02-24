{ config, ... }:

{
  age.secrets.email.file = ../../../secrets/email.notifications.age;

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
      passwordeval = "cat ${config.age.secrets.email.path}";
    };
  };
}
