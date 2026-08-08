{ config, ... }:

{
  services.immich = {
    enable = true;
    mediaLocation = "/media/immich";
    machine-learning.enable = false;
  };

  services.postgresql.dataDir = "/media/postgres/${config.services.postgresql.package.psqlSchema}";

  systemd.services.immich-server.environment = {
    MALLOC_ARENA_MAX = "2";
    VIPS_CONCURRENCY = "2";
  };

  systemd.tmpfiles.rules = [
    "d /media/immich 0750 immich immich -"
  ];
}
