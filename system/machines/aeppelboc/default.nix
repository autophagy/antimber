{
  pkgs,
  inputs,
  hostName,
  ...
}:

{
  nix = {
    gc = {
      automatic = true;
      interval = [
        {
          Day = 1;
          Hour = 3;
          Minute = 15;
        }
      ];
      options = "--delete-older-than 30d";
    };

    optimise.automatic = true;

    registry.nixpkgs.flake = inputs.nixpkgs;

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      keep-outputs = true;
      keep-derivations = true;
      trusted-users = [
        "root"
        "@admin"
      ];
    };
  };

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };

  networking = {
    inherit hostName;
    computerName = "aeppelboc";
  };

  time.timeZone = "Europe/Berlin";

  users.users.mika.home = "/Users/mika";

  programs.zsh.enable = true;

  security.pam.services.sudo_local.touchIdAuth = true;

  fonts.packages = with pkgs; [
    nerd-fonts.inconsolata
    nerd-fonts.dejavu-sans-mono
  ];

  environment.systemPackages = with pkgs; [
    git
    just
  ];

  system = {
    primaryUser = "mika";
    stateVersion = 7;

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };

    defaults = {
      NSGlobalDomain = {
        AppleICUForce24HourTime = true;
        AppleMeasurementUnits = "Centimeters";
        AppleMetricUnits = 1;
        AppleTemperatureUnit = "Celsius";
        ApplePressAndHoldEnabled = false;
        AppleShowAllExtensions = true;
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
      };

      dock = {
        autohide = true;
        mru-spaces = false;
        show-recents = false;
        tilesize = 36;
      };

      finder = {
        AppleShowAllExtensions = true;
        FXPreferredViewStyle = "Nlsv";
        ShowPathbar = true;
        ShowStatusBar = true;
        _FXShowPosixPathInTitle = true;
      };

      screencapture = {
        location = "/Users/mika/Pictures/screenshots";
        type = "png";
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };

      loginwindow.GuestEnabled = false;
    };
  };
}
