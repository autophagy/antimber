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
    utils.url = "github:numtide/flake-utils";
    sops-nix.url = "github:Mic92/sops-nix";
    ansine.url = "github:autophagy/ansine/v1.0.0";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      nixpkgs,
      home-manager,
      nvim-scrollbar,
      herbz-theme,
      nur,
      utils,
      sops-nix,
      ansine,
      nixos-hardware,
      lix-module,
      ...
    }@inputs:
    utils.lib.eachDefaultSystem (
      system:
      let
        overlays = {
          nur = nur.overlays.default;
          nvim-scrollbar = final: prev: {
            vimPackages.nvim-scrollbar = prev.vimUtils.buildVimPluginFrom2Nix {
              pname = "nvim-scrollbar";
              version = "main";
              src = nvim-scrollbar;
            };
          };
        };

        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
          overlays = builtins.attrValues overlays;
        };
      in
      {
        packages = {
          # NixOS Configurations

          nixosConfigurations = {
            heorot = nixpkgs.lib.nixosSystem {
              inherit system;
              modules = [
                ./system/common/configuration.nix
                ./system/machines/heorot
                nixos-hardware.nixosModules.lenovo-thinkpad-x1-9th-gen
                lix-module.nixosModules.default
              ];
              specialArgs = {
                inherit inputs;
                hostName = "heorot";
              };
            };

            gamentol = nixpkgs.lib.nixosSystem {
              inherit system;
              modules = [
                ./system/common/configuration.nix
                ./system/machines/gamentol
              ];
              specialArgs = {
                inherit inputs;
                hostName = "gamentol";
              };
            };

            hindberige = nixpkgs.lib.nixosSystem {
              inherit system;
              modules = [
                ./system/machines/hindberige
                sops-nix.nixosModules.sops
                ansine.nixosModules.default
              ];
              specialArgs = {
                inherit inputs;
                hostName = "hindberige";
              };
            };
          };

          # Homemanager Configurations

          homeConfigurations = {
            heorot = home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              modules = [
                ./home/common/home.nix
                ./home/heorot/home.nix
              ];
              extraSpecialArgs = {
                inherit herbz-theme;
                rootPath = ./.;
                hostName = "heorot";
              };
            };

            gamentol = home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              modules = [
                ./home/common/home.nix
                ./home/gamentol/home.nix
              ];
              extraSpecialArgs = {
                inherit herbz-theme;
                rootPath = ./.;
                hostName = "gamentol";
              };
            };
          };
        };

        devShells.ci = pkgs.mkShell {
          buildInputs = with pkgs; [
            nixfmt-rfc-style
            statix
          ];
        };

        formatter = pkgs.nixfmt-rfc-style;
      }
    );
}
