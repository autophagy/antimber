{ pkgs, ... }:

{
  programs.autorandr = {
    enable = true;
    hooks.postswitch = {
      "notify-i3" = "${pkgs.i3}/bin/i3-msg restart";
      "restart-polybar" = "${pkgs.systemd}/bin/systemctl restart --user polybar";
    };
  };
}
