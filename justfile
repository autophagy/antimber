machine := `hostname`
flake_path := justfile_directory() + "/.#" + machine

[private]
home-manager verb:
    home-manager {{verb}} --flake {{flake_path}}

[private]
nixos verb:
    sudo nixos-rebuild {{verb}} --flake {{flake_path}}

[private]
full verb: (home-manager verb) (nixos verb)

# Build a target (home-manager, nixos, or full)
build target:
    just {{target}} build

# Switch a target (home-manager, nixos, or full)
switch target:
    just {{target}} switch
