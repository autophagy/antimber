_:

{
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts = {
      "hindberige.autophagy.io" = {
        forceSSL = true;
        sslCertificate = "/etc/letsencrypt/live/hindberige.autophagy.io/fullchain.pem";
        sslCertificateKey = "/etc/letsencrypt/live/hindberige.autophagy.io/privkey.pem";
        locations = {
          "/jellyfin" = {
            return = "302 $scheme://localhost/jellyfin/";
          };
          "/jellyfin/" = {
            proxyPass = "http://localhost:8096/jellyfin/";
          };
        };
      };
    };
  };
}

