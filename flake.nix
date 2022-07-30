{
  description = "Configuration for NixOS and home-manager";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvim-scrollbar = {
      url = "github:petertriho/nvim-scrollbar";
      flake = false;
    };

  };

  outputs = { nixpkgs, home-manager, nvim-scrollbar, ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
    in
    {
      nvimPlugins = {
        nvim-scrollbar = pkgs.vimUtils.buildVimPluginFrom2Nix {
          pname = "nvim-scrollbar";
          version = "main";
          src = nvim-scrollbar;
        };
      };
      homeConfigurations.mika = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home/home.nix
        ];
        extraSpecialArgs = { inherit (inputs.self) nvimPlugins; };
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


