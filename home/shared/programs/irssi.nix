{ herbz-theme, ... }:
{
  programs.irssi = {
    enable = true;
    networks = {
      libera = {
        nick = "autophagian";
        server = {
          address = "irc.libera.chat";
          port = 6697;
          autoConnect = true;
        };
        channels = {
          nixos.autoJoin = true;
          rust.autoJoin = true;
          bash.autoJoin = true;
          haskell.autoJoin = true;
          neovim.autoJoin = true;
          python.autoJoin = true;
        };
      };
      otfc = {
        nick = "autophagian";
        server = {
          address = "irc.oftc.net";
          port = 6697;
          autoConnect = true;
        };
        channels = {
          home-manager.autoJoin = true;
        };
      };
    };
  };

  home.file.".irssi/default.theme".source = herbz-theme;
}
