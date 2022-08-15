{ pkgs, config, ... }:
let
  credPath = "${config.home.homeDirectory}/.config/emailCredentials.yaml";
in
{
  imports = [
    ./neomutt.nix
    (import ./immerok.nix { inherit pkgs credPath; })
    (import ./autophagy.nix { inherit pkgs credPath; })
  ];

  home.file.".mailcap".text = ''
    text/html; ${pkgs.w3m}/bin/w3m -I %{charset} -T text/html; copiousoutput;
    application/pdf; ${pkgs.zathura}/bin/zathura %s
  '';

  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
}
