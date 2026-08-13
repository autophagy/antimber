{
  config,
  pkgs,
  fqdn,
  ...
}:

{
  sops.secrets.s3-backup = {
    sopsFile = ../../../secrets/hindberige/s3-backup.env;
    format = "dotenv";
  };

  services = {
    vaultwarden = {
      enable = true;
      config = {
        DOMAIN = "https://${fqdn}/vault/";
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
      Persistent = true;
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
      EnvironmentFile = config.sops.secrets.s3-backup.path;

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
      ReadWritePaths = [ "/var/lib/bitwarden_rs" ];
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
      set -euo pipefail

      ${pkgs.sqlite}/bin/sqlite3 -cmd ".timeout 10000" \
        /var/lib/bitwarden_rs/db.sqlite3 \
        ".backup '/tmp/db.sqlite3'"

      ${pkgs.awscli2}/bin/aws s3 cp /tmp/db.sqlite3 \
        s3://hindberige-backups/vaultwarden/db.sqlite3

      ${pkgs.awscli2}/bin/aws s3 sync /var/lib/bitwarden_rs/ \
        s3://hindberige-backups/vaultwarden/ \
        --exclude 'db.sqlite3' \
        --exclude 'db.sqlite3-shm' \
        --exclude 'db.sqlite3-wal'
    '';
    onFailure = [ "systemd-notify@%n.service" ];
  };
}
