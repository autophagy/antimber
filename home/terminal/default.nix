{ config, inputs, pkgs, ... }:

{
  imports = [
    ./urxvt.nix
    ./zsh.nix
    ./fzf.nix
    ./direnv.nix
  ];
}
