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
    ansine.url = "github:autophagy/ansine/v1.1.1";
    forebodere.url = "github:autophagy/forebodere-rs/v0.1.1";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
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
      forebodere,
      nixos-hardware,
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
          purescript-language-server = final: prev: {
            purescript-language-server = prev.callPackage ./pkgs/purescript-language-server { };
            purs-tidy = prev.callPackage ./pkgs/purs-tidy { };
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
          inherit (pkgs) purescript-language-server;
          inherit (pkgs) purs-tidy;

          # NixOS Configurations

          nixosConfigurations = {
            heorot = nixpkgs.lib.nixosSystem {
              inherit system;
              modules = [
                ./system/common/configuration.nix
                ./system/machines/heorot
                nixos-hardware.nixosModules.lenovo-thinkpad-x1-9th-gen
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
              modules = [
                ./system/machines/hindberige
                sops-nix.nixosModules.sops
                ansine.nixosModules.default
                forebodere.nixosModules.default
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
                ./home/linux/home.nix
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
                ./home/linux/home.nix
                ./home/gamentol/home.nix
              ];
              extraSpecialArgs = {
                inherit herbz-theme;
                rootPath = ./.;
                hostName = "gamentol";
              };
            };

            aeppelboc = home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              modules = [
                ./home/macos/home.nix
                ./home/aeppelboc/home.nix
              ];
              extraSpecialArgs = {
                inherit herbz-theme;
              };
            };
          };
        };

        devShells.ci = pkgs.mkShell {
          buildInputs = with pkgs; [
            nixfmt
            statix
          ];
        };

        formatter = pkgs.nixfmt;
      }
    );
}
