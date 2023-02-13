{ hostName, ... }:

{
  networking = {
    inherit hostName;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22 # SSH
        80 # HTTP
        443 # HTTPS
      ];
      allowedUDPPorts = [
        41641 # Tailscale
      ];
    };
  };
}

