_:

{
  services = {
    openssh = {
      enable = true;
      passwordAuthentication = false;
      kbdInteractiveAuthentication = false;
    };
    tailscale.enable = true;
    jellyfin.enable = true;
    vaultwarden = {
      enable = true;
      config = {
        DOMAIN = "https://hindberige.autophagy.io/vault/";
        ROCKET_PORT = 8222;
      };
    };
    ansine = {
      enable = true;
      port = 3134;
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
      };
    };
  };
}

