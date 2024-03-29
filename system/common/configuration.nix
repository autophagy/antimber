{ pkgs, inputs, hostName, ... }:

{

  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix = {
    # Automatic monthly garbage collection
    gc = {
      automatic = true;
      dates = "monthly";
      options = "--delete-older-than 30d";
    };

    registry.nixpkgs.flake = inputs.nixpkgs;

    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';

    settings.auto-optimise-store = true;
  };

  # Sound.
  hardware.pulseaudio.enable = true;

  # Enable networking
  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      checkReversePath = "loose";
    };
    inherit hostName;
  };

  services.resolved = {
    enable = true;
    dnssec = "false";
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
    enable = true;
    displayManager = {
      lightdm.enable = true;
      defaultSession = "none+i3";
      autoLogin = {
        enable = true;
        user = "mika";
      };
    };
    windowManager.i3.enable = true;
    serverFlagsSection = ''
      Option "BlankTime" "0"
      Option "StandbyTime" "0"
      Option "SuspendTime" "0"
      Option "OffTime" "0"
    '';
  };

  services.tailscale.enable = true;

  users.users.mika = {
    isNormalUser = true;
    description = "Mika Naylor";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "docker" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  services.printing = {
    enable = true;
    drivers = with pkgs; [ brlaser gutenprint ];
    browsing = true;
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  services.udev.packages = [ pkgs.yubikey-personalization ];

  services.pcscd.enable = true;

  environment.systemPackages = with pkgs; [ git just ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
