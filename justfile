machine := `hostname -s`
flake_path := justfile_directory() + "/.#" + machine

[private]
home-manager verb:
    home-manager {{verb}} --flake {{flake_path}}

[private]
nixos verb:
    sudo nixos-rebuild {{verb}} --flake {{flake_path}}

[private]
darwin verb:
    sudo darwin-rebuild {{verb}} --flake {{flake_path}}

[private]
[linux]
full verb: (home-manager verb) (nixos verb)

[private]
[macos]
full verb: (home-manager verb) (darwin verb)

# Build a target (home-manager, nixos, darwin, or full)
build target:
    just {{target}} build

# Switch a target (home-manager, nixos, darwin, or full)
switch target:
    just {{target}} switch

# Deploy a machine's NixOS config from GitHub main: the host itself evaluates,
# pulls the prebuilt closure from cachix, and activates it. Substitute-only
# (--max-jobs 0): a cache miss errors rather than building on the target.
deploy-to machine host=machine:
    ssh -t {{host}} "sudo nixos-rebuild switch --flake github:autophagy/antimber#{{machine}} --refresh --max-jobs 0"
