{ config, pkgs, ... }:

let
  hardening = {
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
    RestrictAddressFamilies = [
      "AF_INET"
      "AF_INET6"
      "AF_UNIX"
    ];
    SystemCallArchitectures = "native";
    SystemCallFilter = [ "@system-service" ];
    CapabilityBoundingSet = "";
  };
in
{
  services.immich = {
    enable = true;
    mediaLocation = "/media/immich";
    machine-learning.enable = false;
  };

  services.postgresql.dataDir = "/media/postgres/${config.services.postgresql.package.psqlSchema}";

  systemd = {
    services = {
      immich-server.environment = {
        MALLOC_ARENA_MAX = "2";
        VIPS_CONCURRENCY = "2";
      };

      immich-db-backup = {
        description = "Backup Immich database";
        after = [ "postgresql.target" ];
        serviceConfig = hardening // {
          Type = "oneshot";
          User = "postgres";
          Group = "postgres";
          EnvironmentFile = config.sops.secrets.s3-backup.path;
        };
        script = ''
          set -euo pipefail

          ${config.services.postgresql.package}/bin/pg_dumpall \
            -h /run/postgresql --clean --if-exists \
            | ${pkgs.gzip}/bin/gzip \
            | ${pkgs.awscli2}/bin/aws s3 cp - \
              s3://hindberige-backups/immich/immich-database.sql.gz
        '';
        onFailure = [ "systemd-notify@%n.service" ];
      };

      immich-media-backup = {
        description = "Backup Immich media";
        serviceConfig = hardening // {
          Type = "oneshot";
          User = "immich";
          Group = "immich";
          EnvironmentFile = config.sops.secrets.s3-backup.path;
        };
        script = ''
          set -euo pipefail

          ${pkgs.awscli2}/bin/aws s3 sync /media/immich/ \
            s3://hindberige-backups/immich/media/ \
            --exclude 'thumbs/*' \
            --exclude 'encoded-video/*' \
            --exclude 'backups/*'
        '';
        onFailure = [ "systemd-notify@%n.service" ];
      };
    };

    timers = {
      immich-db-backup = {
        timerConfig = {
          OnCalendar = "*-*-* 08:15:00";
          Persistent = true;
          Unit = "immich-db-backup.service";
        };
        wantedBy = [ "timers.target" ];
      };

      immich-media-backup = {
        timerConfig = {
          OnCalendar = "*-*-* 08:30:00";
          Persistent = true;
          Unit = "immich-media-backup.service";
        };
        wantedBy = [ "timers.target" ];
      };
    };

    tmpfiles.rules = [
      "d /media/immich 0750 immich immich -"
    ];
  };
}
