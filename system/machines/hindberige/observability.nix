{ config, ... }:

{
  services = {
    prometheus = {
      enable = true;
      stateDir = "prometheus";
      listenAddress = "127.0.0.1";
      retentionTime = "90d";
      globalConfig.scrape_interval = "15s";

      exporters.node = {
        enable = true;
        listenAddress = "127.0.0.1";
      };

      scrapeConfigs = [
        {
          job_name = "node";
          static_configs = [
            {
              targets = [
                "${config.services.prometheus.exporters.node.listenAddress}:${toString config.services.prometheus.exporters.node.port}"
              ];
            }
          ];
        }
      ];
    };

    grafana = {
      enable = true;
      settings.server = {
        http_addr = "127.0.0.1";
        domain = "hindberige.autophagy.io";
        root_url = "%(protocol)s://%(domain)s/grafana/";
        serve_from_sub_path = true;
      };
      settings.security.secret_key = "SW2YcwTIb9zpOOhoPsMm";

      provision.datasources.settings = {
        apiVersion = 1;
        datasources = [
          {
            name = "Prometheus";
            type = "prometheus";
            access = "proxy";
            url = "http://${config.services.prometheus.listenAddress}:${toString config.services.prometheus.port}";
            isDefault = true;
          }
        ];
      };
    };
  };
}
