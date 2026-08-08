_:

{
  boot.tmp.useTmpfs = true;

  boot.initrd.systemd.emergencyAccess = true;
  boot.initrd.verbose = true;
  boot.consoleLogLevel = 7;

  systemd.tmpfiles.rules = [
    "d /media/journal 2755 root systemd-journal -"
  ];

  fileSystems."/var/log/journal" = {
    device = "/media/journal";
    fsType = "none";
    options = [ "bind" ];
    depends = [ "/media" ];
  };

  fileSystems."/nix" = {
    device = "/media/nix";
    fsType = "none";
    options = [ "bind" ];
    neededForBoot = true;
    depends = [ "/media" ];
  };
}
