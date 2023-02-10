{ hostName, ... }:

{
  networking = {
    inherit hostName;
    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
      allowedTCPPorts = [
        22 # SSH
        8096 # Jellyfin HTTP
        8920 # Jellyfin HTTPS
      ];
      allowedUDPPorts = [
        41641 # Tailscale
      ];
    };
  };
}

