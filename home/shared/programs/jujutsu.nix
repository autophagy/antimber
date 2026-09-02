{ common, ... }:

{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        inherit (common.user) name email;
      };
      ui.editor = "hx";
      signing = {
        behavior = "drop";
        backend = "gpg";
        key = common.user.gpgKey;
      };
      git = {
        sign-on-push = true;
        private-commits = "description(glob:'wip:*')";
      };
      revset-aliases."immutable_heads()" = "builtin_immutable_heads() | (trunk().. & ~mine())";
    };
  };
}
