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

    herbz-theme = {
      url = "https://raw.githubusercontent.com/irssi-import/themes/gh-pages/h3rbz.theme";
      flake = false;
    };

    nur.url = "github:nix-community/nur/master";
  };

  outputs = { nixpkgs, home-manager, nvim-scrollbar, herbz-theme, nur, ... }@inputs:
    let
      system = "x86_64-linux";

      overlays = {
        nur = nur.overlay;
      };

      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = builtins.attrValues overlays;
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

      homeConfigurations.heorot = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home/common/home.nix
          ./home/heorot/home.nix
        ];
        extraSpecialArgs = {
          inherit (inputs.self) nvimPlugins;
          inherit herbz-theme;
          rootPath = ./.;
          hostName = "heorot";
        };
      };

      nixosConfigurations.heorot = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./system/common/configuration.nix
          ./system/machines/heorot
        ];
        specialArgs = {
          inherit inputs;
          hostName = "heorot";
        };
      };

      devShells.${system}.ci = pkgs.mkShell {
        buildInputs = with pkgs; [ nixpkgs-fmt statix ];
      };

      formatter.${system} = pkgs.nixpkgs-fmt;
    };
}


