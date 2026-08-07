{ config, pkgs, ... }:

{
  sops.secrets.vaultwarden = {
    sopsFile = ../../../secrets/hindberige/vaultwarden.env;
    format = "dotenv";
  };

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
      EnvironmentFile = config.sops.secrets.vaultwarden.path;

      ProtectSystem = "strict";
      ProtectHome = true;
      PrivateTmp = true;
      PrivateDevices = true;
      NoNewPrivileges = true;
      ProtectKernelTunables = true;
      ProtectKernelModules = true;
      ProtectControlGroups = true;
      RestrictSUIDSGID = true;
      RestrictNamespaces = true;
      LockPersonality = true;
      ReadOnlyPaths = [ "/var/lib/bitwarden_rs" ];
      RestrictAddressFamilies = [
        "AF_INET"
        "AF_INET6"
        "AF_UNIX"
      ];
      SystemCallArchitectures = "native";
      SystemCallFilter = [ "@system-service" ];
      CapabilityBoundingSet = "";
    };
    script = ''
      ${pkgs.awscli2}/bin/aws s3 sync /var/lib/bitwarden_rs/ s3://hindberige-backups/vaultwarden/
    '';
    onFailure = [ "systemd-notify@%n.service" ];
  };
}
