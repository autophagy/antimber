{ config, lib, ansine, pkgs, ... }:

with lib;

let
  cfg = config.services.ansine;
  user = "ansine";
  group = user;
  cfgFile = pkgs.writeText "ansine-config.json" (builtins.toJSON {
    inherit (cfg) services port nixosCurrentSystem refreshInterval;
  });
in
{
  options = {
    services.ansine = {
      enable = mkEnableOption (lib.mdDoc "Ansine");

      port = mkOption {
        type = types.port;
        default = 3000;
        description = lib.mdDoc "Port number Ansine will listen to.";
      };

      nixosCurrentSystem = mkOption {
        type = types.bool;
        default = true;
        description = lib.mdDoc "Whether to display the current NixOS generation via /run/current-system.";
      };

      refreshInterval = mkOption {
        type = types.int;
        default = 10;
        description = lib.mdDoc "The interval, in seconds, that the dashboard should refresh system metrics";
      };

      services = mkOption {
        default = { };
        description = lib.mdDoc "Services to expose on the Ansine dashboard";
        type = types.attrsOf (types.submodule (_: {
          options = {
            description = mkOption {
              type = types.str;
              default = "";
              description = lib.mdDoc "Service description";
            };

            route = mkOption {
              type = types.str;
              default = "";
              description = lib.mdDoc "Service route from host";
            };
          };
        }));
      };
    };
  };

  config = mkIf cfg.enable {
    users.users.${user} = {
      inherit group;
      description = "Ansine system user";
      isSystemUser = true;
    };

    users.groups = {
      ansine = { };
    };

    systemd.services = {
      ansine = {
        description = "Ansine service";
        after = [ "network.target" ];
        environment = {
          ANSINE_CONFIG_PATH = cfgFile;
        };
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Restart = "on-failure";
          User = user;
          Group = group;
          ExecStart = "${ansine}/bin/ansine";
        };
      };
    };
  };
}
