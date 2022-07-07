{
  description = "Configuration for NixOS and home-manager";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };

      lib = nixpkgs.lib;
    in
    {
      homeConfigurations."mika" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./homemanager/home.nix
        ];
      };
      nixosConfigurations."heorot" = lib.nixosSystem {
        inherit system;
        modules = [
          ./system/configuration.nix
        ];
        specialArgs = { inherit inputs; };
      };

    };
}


