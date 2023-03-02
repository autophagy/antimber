{ pkgs, config, ... }:
{
  imports = [
    ./neomutt.nix
    ./autophagy.nix
  ];

  home.file.".mailcap".text = ''
    text/html; ${pkgs.w3m}/bin/w3m -I %{charset} -T text/html; copiousoutput;
    application/pdf; ${pkgs.zathura}/bin/zathura %s
  '';

  home.file.mail = {
    source = ../../../secrets/email.yaml;
    target = ".config/email.yaml";
  };

  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
}
