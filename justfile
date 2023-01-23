machine := `hostname`
flake_path := "~/" + machine + "/autophagy/antimber/.#" + machine

# Switch home manager config
home-manager:
    home-manager switch --flake {{flake_path}}

# Switch nixos config
nixos:
    sudo nixos-rebuild switch --flake {{flake_path}}

# Switch both home manager and nixos
full: home-manager nixos
