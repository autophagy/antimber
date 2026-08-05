{ lib, ... }:

{
  home = {
    username = lib.mkDefault "mika";
    stateVersion = "22.05";
  };

  nixpkgs.config.allowUnfree = true;
}
