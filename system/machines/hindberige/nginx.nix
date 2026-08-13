{ fqdn, ... }:

{
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    appendHttpConfig = ''
      add_header X-Content-Type-Options "nosniff" always;
      add_header X-Frame-Options "SAMEORIGIN" always;
      add_header Referrer-Policy "strict-origin-when-cross-origin" always;
      add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
    '';
    virtualHosts = {
      "${fqdn}" = {
        forceSSL = true;
        sslCertificate = "/var/nginx/certs/${fqdn}/fullchain.pem";
        sslCertificateKey = "/var/nginx/certs/${fqdn}/privkey.pem";
        locations = {
          "/" = {
            proxyPass = "http://localhost:3134";
          };
          "/jellyfin/" = {
            proxyPass = "http://localhost:8096/jellyfin/";
            proxyWebsockets = true;
            extraConfig = ''
              proxy_buffering off;
            '';
          };
          "/vault/" = {
            proxyPass = "http://localhost:8222";
            proxyWebsockets = true;
          };
          "/vault/notifications/hub" = {
            proxyPass = "http://localhost:3012";
            proxyWebsockets = true;
          };
          "/vault/notifications/hub/negotiate" = {
            proxyPass = "http://localhost:8222";
            proxyWebsockets = true;
          };
          "/sabnzbd" = {
            proxyPass = "http://localhost:8080/sabnzbd";
          };
          "/grafana/" = {
            proxyPass = "http://localhost:3000";
            proxyWebsockets = true;
          };
          "/photos/" = {
            return = "301 https://photos.${fqdn}/";
          };
        };
      };

      "photos.${fqdn}" = {
        forceSSL = true;
        sslCertificate = "/var/nginx/certs/photos.${fqdn}/fullchain.pem";
        sslCertificateKey = "/var/nginx/certs/photos.${fqdn}/privkey.pem";
        locations."/" = {
          proxyPass = "http://localhost:2283";
          proxyWebsockets = true;
          extraConfig = ''
            client_max_body_size 50000M;
            proxy_request_buffering off;
            client_body_buffer_size 1024k;
            proxy_read_timeout 600s;
            proxy_send_timeout 600s;
          '';
        };
      };
    };
  };
}
