{ pkgs, config, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/sda";
      useOSProber = true;
      enableCryptodisk = true;
    };

    # Setup keyfile
    initrd = {
      secrets = {
        "/crypto_keyfile.bin" = null;
      };

      luks.devices = {
        "luks-9ec0eeb9-f902-46af-99ee-1b5f5c415caf".keyFile = "/crypto_keyfile.bin";
        # Enable swap on luks
        "luks-5ad23ef1-f79e-4cd1-b24e-745d03f70562".device = "/dev/disk/by-uuid/5ad23ef1-f79e-4cd1-b24e-745d03f70562";
        "luks-5ad23ef1-f79e-4cd1-b24e-745d03f70562".keyFile = "/crypto_keyfile.bin";
      };
    };
  };

  nixpkgs.config.allowUnfree = true;

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  services.fstrim.enable = true;
}
