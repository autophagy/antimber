{ config, pkgs, hostName, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  networking.hostName = hostName;

  users = {
    motd = ''

         .~~.   .~~.
        '. \ ' ' / .'
         .~ .~~~..~.
        : .~.'~'.~. :
       ~ (   ) (   ) ~
      ( : '~'.~.'~' : )
       ~ .~ (   ) ~. ~
        (  : '~' :  )
         '~ .~~~. ~'
             '~'

    '';
    users.mika = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICIdbr5D6l66CFklBLi1Dl8ybAlEPu6k7Ve6B+Z+itZO mail@autophagy.io" # Heorot
      ];
    };
  };

  environment.systemPackages = with pkgs; [ vim git just ];
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
  };

  networking.firewall.enable = false;

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };

  system.stateVersion = "22.11";
}

