{ ... }:

{
  imports = [
    ./git.nix
    ./i3.nix
    ./rofi.nix
    ./discord.nix
    ./bat.nix
    ./irssi.nix
  ];

  programs.home-manager.enable = true;
  programs.gh.enable = true;
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.autorandr.enable = true;
}
