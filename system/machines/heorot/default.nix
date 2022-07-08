{ config, pkgs, ... }:

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

  networking.hostName = "heorot";
}
