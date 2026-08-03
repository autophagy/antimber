_:

{
  boot.tmp.useTmpfs = true;

  systemd.tmpfiles.rules = [
    "d /media/journal 2755 root systemd-journal -"
  ];

  fileSystems."/var/log/journal" = {
    device = "/media/journal";
    fsType = "none";
    options = [ "bind" ];
    depends = [ "/media" ];
  };
}
