{ hostName, ... }:

{
  networking = {
    inherit hostName;
    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
      allowedTCPPorts = [ ];
      interfaces.end0.allowedTCPPorts = [
        22 # SSH break-glass
      ];
      allowedUDPPorts = [
        41641 # Tailscale
      ];
    };
  };
}
