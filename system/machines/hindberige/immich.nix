_:

{
  services.immich = {
    enable = true;
    mediaLocation = "/media/immich";
    machine-learning.enable = false;
  };

  systemd.tmpfiles.rules = [
    "d /media/immich 0750 immich immich -"
  ];
}
