_:

{
  boot.tmp.useTmpfs = true;

  boot.initrd.systemd.emergencyAccess = true;

  systemd.tmpfiles.rules = [
    "d /media/journal 2755 root systemd-journal -"
    "d /media/sabnzbd 0700 sabnzbd sabnzbd -"
  ];

  fileSystems = {
    "/var/log/journal" = {
      device = "/media/journal";
      fsType = "none";
      options = [ "bind" ];
      depends = [ "/media" ];
    };

    "/nix" = {
      device = "/media/nix";
      fsType = "none";
      options = [ "bind" ];
      neededForBoot = true;
      depends = [ "/media" ];
    };

    "/var/lib/sabnzbd" = {
      device = "/media/sabnzbd";
      fsType = "none";
      options = [ "bind" ];
      depends = [ "/media" ];
    };
  };
}
