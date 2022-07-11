{ config, inputs, pkgs, ... }:

{
  imports = [ ./vim.nix ];

  programs.vscode.enable = true;
}
