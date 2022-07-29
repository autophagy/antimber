{
  description = "Configuration for NixOS and home-manager";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
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

    in
    {
      homeConfigurations.mika = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home/home.nix
        ];
      };
      nixosConfigurations.heorot = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./system/machines/heorot
          ./system/configuration.nix
        ];
        specialArgs = { inherit inputs; };
      };
      devShells.${system}.ci = pkgs.mkShell {
        buildInputs = with pkgs; [ nixpkgs-fmt statix ];
      };
    };
}


