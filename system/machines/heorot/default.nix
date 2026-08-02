{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };

    # Setup keyfile
    initrd.secrets = {
      "/crypto_keyfile.bin" = null;
    };
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-a49798c8-95a6-4e7d-993b-5f223edbf853".device =
    "/dev/disk/by-uuid/a49798c8-95a6-4e7d-993b-5f223edbf853";
  boot.initrd.luks.devices."luks-a49798c8-95a6-4e7d-993b-5f223edbf853".keyFile =
    "/crypto_keyfile.bin";

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  hardware = {

    enableRedistributableFirmware = true;

    bluetooth = {
      enable = true;
      powerOnBoot = pkgs.lib.mkForce false;
    };

    graphics = {
      enable = true;
      package = pkgs.mesa.drivers;

      extraPackages = with pkgs; [
        libGL
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
        intel-media-driver
      ];

      package32 = pkgs.pkgsi686Linux.mesa.drivers;
      enable32Bit = true;
    };
  };

  services = {
    xserver = {
      videoDrivers = [
        "modesetting"
        "intel"
        "libvulkan1"
        "mesa-vulkan-drivers"
        "vulkan-utils"
      ];
    };

    libinput.enable = true;
  };

  virtualisation = {
    docker.enable = true;
    podman.enable = true;
  };

  programs.light.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  nixpkgs.config.allowUnfree = true;

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.sway}/bin/sway";
        user = "mika";
      };
      default_session = initial_session;
    };
  };

  security.polkit.enable = true;
  security.pam.services.swaylock = { };
}
