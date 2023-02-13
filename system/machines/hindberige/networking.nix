{ hostName, ... }:

{
  networking = {
    inherit hostName;
    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
      allowedTCPPorts = [
        22 # SSH
      ];
      allowedUDPPorts = [
        41641 # Tailscale
      ];
    };
  };
}

