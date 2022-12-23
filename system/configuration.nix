{ pkgs, inputs, ... }:

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

  # Bluetooth.
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = pkgs.lib.mkForce false;
  };

  hardware.opengl = {
    enable = true;
    package = pkgs.mesa.drivers;

    extraPackages = with pkgs; [
      libGL
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-media-driver
    ];
    setLdLibraryPath = true;

    package32 = pkgs.pkgsi686Linux.mesa.drivers;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Enable networking
  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      checkReversePath = "loose";
    };
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
    };
    windowManager.i3.enable = true;

    libinput.enable = true;
    videoDrivers = [ "modesetting" "intel" "libvulkan1" "mesa-vulkan-drivers" "vulkan-utils" ];
  };

  virtualisation = {
    docker.enable = true;
    podman.enable = true;
  };

  services.tailscale.enable = true;

  users.users.mika = {
    isNormalUser = true;
    description = "Mika Naylor";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "docker" ];
    shell = pkgs.zsh;
  };

  programs.light.enable = true;

  environment.systemPackages = with pkgs; [ ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
