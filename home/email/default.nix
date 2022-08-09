{ pkgs, ... }:

{
  imports = [ ./neomutt.nix ./immerok.nix ./autophagy.nix ];

  home.file.".mailcap".text = ''
    text/html; ${pkgs.w3m}/bin/w3m -I %{charset} -T text/html; copiousoutput;
    application/pdf; ${pkgs.zathura}/bin/zathura %s
  '';

  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
}
