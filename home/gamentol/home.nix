{ pkgs, ... }:

{
  imports = [
    ./services
    ./programs
  ];

  home.packages = with pkgs; [ ];
}
