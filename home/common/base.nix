{ lib, ... }:

{
  home = {
    username = lib.mkDefault "mika";
    homeDirectory = lib.mkDefault "/home/mika";
    stateVersion = "22.05";
  };

  nixpkgs.config.allowUnfree = true;
}
