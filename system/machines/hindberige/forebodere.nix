{ config, pkgs, ... }:

{
  sops.secrets.forebodere = {
    sopsFile = ../../../secrets/hindberige/forebodere.env;
    format = "dotenv";
  };

  services = {
    forebodere = {
      enable = true;
      environmentFile = config.sops.secrets.forebodere.path;
      settings = {
        prefix = "!";
        lol_quiet_gap_seconds = 5;
        laugh_words = [
          "lol"
          "lmao"
          "rofl"
          "ha"
          "lo"
        ];
        reactions = [
          {
            phrase = "my wife";
            emoji = "murk";
          }
        ];
        lol_tier_messages = {
          low = "Multilol!";
          medium = "Ultralol!";
          high = "M-M-M-MONSTERLOL!";
        };
        markov_default_order = 2;
      };
    };
  };

  systemd.services.forebodere-backup = {
    description = "Backup Forebodere DB";
    serviceConfig = {
      Type = "oneshot";
      User = "forebodere";
      Group = "forebodere";
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
        /var/lib/forebodere/forebodere.db \
        ".backup '/tmp/forebodere.db'"

      ${pkgs.awscli2}/bin/aws s3 cp /tmp/forebodere.db \
        s3://hindberige-backups/forebodere/forebodere.db
    '';
    onFailure = [ "systemd-notify@%n.service" ];
  };

  systemd.timers.forebodere-backup = {
    timerConfig = {
      OnCalendar = "*-*-* 04:00:00";
      Persistent = true;
      Unit = "forebodere-backup.service";
    };
    wantedBy = [ "timers.target" ];
  };
}
