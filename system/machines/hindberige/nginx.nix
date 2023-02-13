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
        sslCertificate = "/var/nginx/certs/hindberige.autophagy.io/fullchain.pem";
        sslCertificateKey = "/var/nginx/certs/hindberige.autophagy.io/privkey.pem";
        locations = {
          "/jellyfin" = {
            return = "302 $scheme://$host/jellyfin/";
          };
          "/jellyfin/" = {
            proxyPass = "http://localhost:8096/jellyfin/";
            extraConfig = ''
              proxy_buffering off;
            '';
          };
        };
      };
    };
  };
}

