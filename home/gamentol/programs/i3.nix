{ pkgs, ... }:

{
  xsession.windowManager.i3 = {
    config = {
      startup = [
        { command = "${pkgs.autorandr}/bin/autorandr -c"; }
      ];
    };
  };
}
