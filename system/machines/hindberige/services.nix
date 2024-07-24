_:

{
  services = {
    openssh = {
      enable = true;
      passwordAuthentication = false;
      kbdInteractiveAuthentication = false;
    };
    tailscale.enable = true;
    jellyfin = {
      enable = true;
      openFirewall = true; # Temporary until Tailscale & range requests works
    };
    vaultwarden = {
      enable = true;
      config = {
        DOMAIN = "https://hindberige.autophagy.io/vault/";
        ROCKET_PORT = 8222;
      };
    };
    sabnzbd.enable = true;
    ansine = {
      enable = true;
      settings = {
        port = 3134;
        nixosCurrentSystem = true;
        refreshInterval = 3;
        services = {
          Jellyfin = {
            description = "Media system";
            route = "/jellyfin/";
          };
          Vaultwarden = {
            description = "Bitwarden compatible credential storage";
            route = "/vault/";
          };
          SABnzbd = {
            description = "Usenet NZB reader";
            route = "/sabnzbd";
          };
        };
      };
    };
  };
}
