{ lib, ... }:

{
  imports = [ ../shared/home.nix ];

  home.homeDirectory = lib.mkDefault "/Users/mika";
}
