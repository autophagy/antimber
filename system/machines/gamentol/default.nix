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

  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      displayManager.lightdm.enable = true;
      windowManager.i3.enable = true;
      serverFlagsSection = ''
        Option "BlankTime" "0"
        Option "StandbyTime" "0"
        Option "SuspendTime" "0"
        Option "OffTime" "0"
      '';
      videoDrivers = [ "nvidia" ];
    };

    displayManager = {
      defaultSession = "none+i3";
      autoLogin = {
        enable = true;
        user = "mika";
      };
    };
  };

  hardware.graphics.enable = true;

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    open = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  services.fstrim.enable = true;
}
