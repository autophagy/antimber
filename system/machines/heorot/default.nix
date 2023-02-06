{ pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-a49798c8-95a6-4e7d-993b-5f223edbf853".device = "/dev/disk/by-uuid/a49798c8-95a6-4e7d-993b-5f223edbf853";
  boot.initrd.luks.devices."luks-a49798c8-95a6-4e7d-993b-5f223edbf853".keyFile = "/crypto_keyfile.bin";

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  hardware.enableRedistributableFirmware = true;

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

  services.xserver = {
    libinput.enable = true;
    videoDrivers = [ "modesetting" "intel" "libvulkan1" "mesa-vulkan-drivers" "vulkan-utils" ];
  };

  virtualisation = {
    docker.enable = true;
    podman.enable = true;
  };

  programs.light.enable = true;
}
