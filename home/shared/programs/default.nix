{ ... }:

{
  imports = [
    ./git.nix
    ./jujutsu.nix
    ./bat.nix
    ./irssi.nix
    ./ssh.nix
    ./discord.nix
  ];

  programs.home-manager.enable = true;
  programs.gh.enable = true;
}
