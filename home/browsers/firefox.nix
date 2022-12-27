{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      ublock-origin
      duckduckgo-privacy-essentials
      privacy-badger
      firefox-translations
    ];
    profiles = {
      default = {
        name = "mika";
        path = "s45qaa2p.mika";
        id = 0;

        search = {
          default = "DuckDuckGo";
          engines = {
            "Nix Packages" = {
              urls = [{
                template = "https://search.nixos.org/packages";
                params = [
                  { name = "type"; value = "packages"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@n" ];
            };
          };
        };

        bookmarks = [
          { name = "Financial Times"; keyword = "ft"; url = "https://ft.com"; }
          { name = "Github"; keyword = "github"; url = "https://github.com"; }
          { name = "Hacker News"; keyword = "hn"; url = "https://news.ycombinator.com"; }
        ];
      };
    };
  };
}
