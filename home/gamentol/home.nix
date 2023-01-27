{ pkgs, ... }:

{
  imports = [
    ./services
  ];

  home.packages = with pkgs; [ ];
}
