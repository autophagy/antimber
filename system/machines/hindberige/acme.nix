{ config, fqdn, ... }:

{
  sops.secrets.cloudflare-dns = {
    sopsFile = ../../../secrets/hindberige/cloudflare.yaml;
    key = "dns-api-token";
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "mail@autophagy.io";
    certs.${fqdn} = {
      extraDomainNames = [ "*.${fqdn}" ];
      group = config.services.nginx.group;
      dnsProvider = "cloudflare";
      credentialFiles.CF_DNS_API_TOKEN_FILE = config.sops.secrets.cloudflare-dns.path;
    };
  };

  systemd.services."acme-${fqdn}".onFailure = [ "systemd-notify@%n.service" ];
}
