_:

{
  services = {
    openssh = {
      enable = true;
      openFirewall = false; # Reachable over Tailscale + end0 (see networking.nix)
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [
          "mika"
          "emily"
        ];
      };
    };
    tailscale = {
      enable = true;
      useRoutingFeatures = "server"; # exit node
    };
    jellyfin = {
      enable = true;
      openFirewall = false;
      cacheDir = "/media/jellyfin/cache";
    };
    sabnzbd.enable = true;
    ansine = {
      enable = true;
      settings = {
        port = 3134;
        nixosCurrentSystem = true;
        refreshInterval = 3;
        services = [
          {
            name = "Jellyfin";
            description = "Media system";
            route = "/jellyfin/";
          }
          {
            name = "Vaultwarden";
            description = "Bitwarden compatible credential storage";
            route = "/vault/";
          }
          {
            name = "Immich";
            description = "Photo management";
            route = "/photos/";
          }
          {
            name = "SABnzbd";
            description = "Usenet NZB reader";
            route = "/sabnzbd/";
          }
          {
            name = "Grafana";
            description = "Metrics dashboards";
            route = "/grafana/";
          }
        ];
      };
    };
  };
}
