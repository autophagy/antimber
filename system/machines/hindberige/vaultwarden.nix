{ config, pkgs, ... }:

{
  age.secrets.vaultwarden.file = ../../../secrets/vaultwarden.age;

  services = {
    vaultwarden = {
      enable = true;
      config = {
        DOMAIN = "https://hindberige.autophagy.io/vault/";
        ROCKET_PORT = 8222;
        SIGNUPS_ALLOWED = false;
        SIGNUPS_VERIFY = true;
        INVITATIONS_ALLOWED = true;
      };
    };
  };

  systemd.timers.vaultwarden-backup = {
    timerConfig = {
      OnCalendar = "*-*-* 08:00:00";
      Unit = "vaultwarden-backup.service";
    };
    wantedBy = [ "timers.target" ];
  };

  systemd.services.vaultwarden-backup = {
    description = "Backup Vaultwarden";
    serviceConfig = {
      Type = "oneshot";
      User = "vaultwarden";
      Group = "vaultwarden";
      EnvironmentFile = config.age.secrets.vaultwarden.path;
    };
    script = ''
      ${pkgs.awscli2}/bin/aws s3 sync /var/lib/bitwarden_rs/ s3://hindberige-backups/vaultwarden/
    '';
    onFailure = [ "systemd-notify@%n.service" ];
  };
}

