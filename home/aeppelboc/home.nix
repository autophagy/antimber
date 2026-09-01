{
  config,
  lib,
  pkgs,
  ...
}:

let
  signingKey = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
in
{
  home.packages = with pkgs; [ claude-code ];

  programs = {
    git = {
      signing.key = lib.mkForce signingKey;
      settings.gpg.format = "ssh";
    };

    jujutsu.settings.signing = {
      backend = lib.mkForce "ssh";
      key = lib.mkForce signingKey;
    };

    ssh.settings."github.com" = {
      AddKeysToAgent = "yes";
      UseKeychain = "yes";
      IdentityFile = "~/.ssh/id_ed25519";
    };
  };
}
