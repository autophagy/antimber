{ pkgs, ... }:

{
  systemd.user.services.podman-prune = {
    Unit = {
      Description = "Prune podman resources";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.podman}/bin/podman system prune -f";
      Environment = "PATH=/run/current-system/sw/bin";
    };
  };

  systemd.user.timers.podman-prune = {
    Unit = {
      Description = "Prune podman resources";
    };
    Timer = {
      OnCalendar = "weekly";
      Persistent = true;
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
