{ config, ... }:

{
  sops.secrets.forebodere = {
    sopsFile = ../../../secrets/hindberige/forebodere.env;
    format = "dotenv";
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
    oci-containers = {
      backend = "podman";
      containers = {
        forebodere = {
          image = "localhost/forebodere:latest";
          volumes = [ "/home/mika/storage/forebodere.hord:/app/forebodere.hord" ];
          environmentFiles = [ config.sops.secrets.forebodere.path ];
        };
      };
    };
  };
}
