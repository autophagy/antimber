{ ... }:

{
  imports = [
    ./git.nix
    ./i3.nix
    ./rofi.nix
    ./discord.nix
    ./bat.nix
  ];

  programs.home-manager.enable = true;
  programs.gh.enable = true;
}
