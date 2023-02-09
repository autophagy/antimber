{ config, pkgs, hostName, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot = {
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
    kernel.sysctl = {
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };
    cleanTmpDir = true;
  };

  documentation.nixos.enable = false;
  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

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
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFhx/eQ3TXkbtbT//g+I29aI6iQoZA8sks5OAK/bEALP mail@autophagy.io" # Gamentol
      ];
    };
  };

  environment.systemPackages = with pkgs; [ vim git just htop wget ];
  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];
    allowedTCPPorts = [
      22 # SSH
      8096 # Jellyfin HTTP
      8920 # Jellyfin HTTPS
    ];
    allowedUDPPorts = [
      41641 # Tailscale
    ];
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };


  services = {
    openssh = {
      enable = true;
      passwordAuthentication = false;
      kbdInteractiveAuthentication = false;
    };
    tailscale.enable = true;
    jellyfin.enable = true;
  };

  system.stateVersion = "22.11";
}

