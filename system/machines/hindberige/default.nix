{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ./virtualization.nix
    ./services.nix
    ./nginx.nix
    ./vaultwarden.nix
    ./mail.nix
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
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [ "https://autophagy.cachix.org" ];
      trusted-public-keys = [ "autophagy.cachix.org-1:aOfvRQFCgIVXyAxlQjl3ccmlQC70X1ukzr4rDgaCMWw=" ];
    };
  };
  nixpkgs.config.allowUnfree = true;

  users = {
    motd = builtins.readFile ./motd;
    users = {
      mika = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "sabnzbd"
        ];
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC0EdkL/Fvhyh1G43rRVcZPZWga1m6nO6Io0G9uJE+jFb59zICccyQs6TerFckzNsVG7wssVD2M7ls2VX5ggPefDMHeWQbGuwk8DG3B5RsIAlcZHeXze2hI9LugfpDtA068QDJnGyFiLg1QnQS3hfQuC0Ra7OJ9XAb8blnF9PLvzFp1diNPUXZ1ks8udRzIl99DoLcitxLqG6R8p0WUyzVRL+EU/zL6/YbGAgoUUpTH4dAHFfe/AfPzRs4MsSwVsrnA+ohmp8sp/GNpU6tnFafeT0IkfIrfVPSfj45x+IlmlLIKi32xFLbsbUx0irynAJQ6K/DpgUqoNzCjShl/i0LT+vE/v6n8Jmqkbf5Air/g9lJ3aZeK3BISdDHeRHirU7w34r+rdVBtMyyX3E91jE2VhiuJ8GkT4jiAke/Y+bWkaY7pjv5YZMl8txyMwgQIEWGatJaTv1h4zsBNUVWavI61LXVERAI9n1FUw/4zNpZ+LExxqnbGXp0jlRGJcutXB8XQ3+Bz7uaazQNgci0hNpTIXZnlWV1eYtWl+KP39sPab1UhNd1o57Rnd35W5VXE06/Na7eTr7hcydFzWajW5JcqxOgZE8d/xta1DhL9o2RqdAcNkzNPMiFvQ8A0iiOAmVht9MpVQaBCb0jn7FUTNiKjP6ARsXwgUBMtnVxajkSozw== openpgp:0x74DABE5E"
        ];
      };
      emily = {
        isNormalUser = true;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMd0dU/DlOGxmkIgbWqWuSzNPMkKUQQht4AN42Sixx0r hello@emilywoods.me"
        ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    just
    htop
    wget
  ];

  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  system.stateVersion = "22.11";
}
