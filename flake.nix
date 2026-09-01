{
  description = "Configuration for NixOS and home-manager";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    herbz-theme = {
      url = "https://raw.githubusercontent.com/irssi-import/themes/gh-pages/h3rbz.theme";
      flake = false;
    };
    nur.url = "github:nix-community/nur/master";
    utils.url = "github:numtide/flake-utils";
    sops-nix.url = "github:Mic92/sops-nix";
    ansine.url = "github:autophagy/ansine";
    forebodere.url = "github:autophagy/forebodere-rs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };
  outputs =
    {
      nixpkgs,
      home-manager,
      nix-darwin,
      herbz-theme,
      nur,
      utils,
      sops-nix,
      ansine,
      forebodere,
      nixos-hardware,
      ...
    }@inputs:
    let
      overlays = {
        nur = nur.overlays.default;
        purescript-language-server = final: prev: {
          purescript-language-server = prev.callPackage ./pkgs/purescript-language-server { };
          purs-tidy = prev.callPackage ./pkgs/purs-tidy { };
        };
        pi-coding-agent = final: prev: {
          pi-coding-agent = prev.callPackage ./pkgs/pi-coding-agent { };
        };
      };

      pkgsFor =
        system:
        import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
          overlays = builtins.attrValues overlays;
        };
    in
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = pkgsFor system;
      in
      {
        packages = {
          inherit (pkgs) purescript-language-server;
          inherit (pkgs) purs-tidy;
          inherit (pkgs) pi-coding-agent;
        };

        devShells.ci = pkgs.mkShell {
          buildInputs = with pkgs; [
            nixfmt
            statix
          ];
        };

        formatter = pkgs.nixfmt;
      }
    )
    // {

      # NixOS Configurations

      nixosConfigurations = {
        heorot = nixpkgs.lib.nixosSystem {
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
            fqdn = "hindberige.autophagy.io";
          };
        };
      };

      # Homemanager Configurations

      homeConfigurations = {
        heorot = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor "x86_64-linux";
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
          pkgs = pkgsFor "x86_64-linux";
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
          pkgs = pkgsFor "aarch64-darwin";
          modules = [
            ./home/macos/home.nix
            ./home/aeppelboc/home.nix
          ];
          extraSpecialArgs = {
            inherit herbz-theme;
          };
        };
      };

      # Darwin Configurations

      darwinConfigurations = {
        aeppelboc = nix-darwin.lib.darwinSystem {
          modules = [ ./system/machines/aeppelboc ];
          specialArgs = {
            inherit inputs;
            hostName = "aeppelboc";
          };
        };
      };
    };
}
