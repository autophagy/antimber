{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [ claude-code ];

  programs.git = {
    signing.key = lib.mkForce "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
    settings.gpg.format = "ssh";
  };

  programs.ssh.settings."github.com" = {
    AddKeysToAgent = "yes";
    UseKeychain = "yes";
    IdentityFile = "~/.ssh/id_ed25519";
  };
}
