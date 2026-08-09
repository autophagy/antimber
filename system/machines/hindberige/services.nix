{ config, ... }:

{
  sops.secrets.forebodere = {
    sopsFile = ../../../secrets/hindberige/forebodere.env;
    format = "dotenv";
  };

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
    vaultwarden = {
      enable = true;
      config = {
        DOMAIN = "https://hindberige.autophagy.io/vault/";
        ROCKET_PORT = 8222;
      };
    };
    sabnzbd.enable = true;
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
          Immich = {
            description = "Photo management";
            route = "/photos/";
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
