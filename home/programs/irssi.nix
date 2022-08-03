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
          nixos-chat.autoJoin = true;
          nixos-dev.autoJoin = true;
          rust.autoJoin = true;
          bash.autoJoin = true;
          haskell.autoJoin = true;
          neovim.autoJoin = true;
          python.autoJoin = true;
        };
      };
    };
  };

  home.file.".irssi/default.theme".source = herbz-theme;
}
