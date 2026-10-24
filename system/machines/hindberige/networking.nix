{ hostName, fqdn, ... }:

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

  services.dnsmasq = {
    enable = true;
    resolveLocalQueries = false;
    settings = {
      interface = "tailscale0";
      bind-dynamic = true;
      no-resolv = true;
      address = [ "/${fqdn}/100.121.203.88" ];
    };
  };
}
