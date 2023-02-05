{ ... }:

{
  imports = [
    ./git.nix
    ./i3.nix
    ./rofi.nix
    ./discord.nix
    ./bat.nix
    ./irssi.nix
    ./autorandr.nix
    ./gpg.nix
    ./ssh.nix
  ];

  programs.home-manager.enable = true;
  programs.gh.enable = true;
}
