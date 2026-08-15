{ config, pkgs, ... }:

let
  llamaHost = "127.0.0.1";
  llamaPort = 8090;
in
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
        llm_endpoint = "http://${llamaHost}:${toString llamaPort}";
        otlp_endpoint = "http://${config.services.prometheus.listenAddress}:${toString config.services.prometheus.port}/api/v1/otlp/v1/metrics";
      };
    };
  };

  users.users.llama-server = {
    isSystemUser = true;
    group = "llama-server";
    description = "llama-server system user";
  };
  users.groups.llama-server = { };

  systemd = {
    services = {
      llama-server = {
        description = "llama.cpp server for forebodere";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          ExecStart = "${pkgs.llama-cpp}/bin/llama-server -m /media/models/fused-360m-instruct/ggml-model-q4_k_m.gguf --host ${llamaHost} --port ${toString llamaPort} --metrics";
          Restart = "on-failure";
          RestartSec = 5;
          User = "llama-server";
          Group = "llama-server";

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
          ];
          SystemCallArchitectures = "native";
          SystemCallFilter = [ "@system-service" ];
          CapabilityBoundingSet = "";
        };
      };

      forebodere.after = [ "llama-server.service" ];

      forebodere-backup = {
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
    };

    timers.forebodere-backup = {
      timerConfig = {
        OnCalendar = "*-*-* 04:00:00";
        Persistent = true;
        Unit = "forebodere-backup.service";
      };
      wantedBy = [ "timers.target" ];
    };
  };
}
