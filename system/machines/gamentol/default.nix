{ pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable grub cryptodisk
  boot.loader.grub.enableCryptodisk = true;

  boot.initrd.luks.devices."luks-9ec0eeb9-f902-46af-99ee-1b5f5c415caf".keyFile = "/crypto_keyfile.bin";
  # Enable swap on luks
  boot.initrd.luks.devices."luks-5ad23ef1-f79e-4cd1-b24e-745d03f70562".device = "/dev/disk/by-uuid/5ad23ef1-f79e-4cd1-b24e-745d03f70562";
  boot.initrd.luks.devices."luks-5ad23ef1-f79e-4cd1-b24e-745d03f70562".keyFile = "/crypto_keyfile.bin";
}
