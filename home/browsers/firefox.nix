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
          force = true;
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
              definedAliases = [ "@nixpkgs" ];
            };

            "YouTube" = {
              urls = [{
                template = "https://www.youtube.com/results";
                params = [
                  { name = "search_query"; value = "{searchTerms}"; }
                ];
              }];
              definedAliases = [ "@youtube" ];
            };

            "Google Maps" = {
              urls = [{ template = "https://www.google.com/maps/search/{searchTerms}"; }];
              definedAliases = [ "@maps" ];
            };

            "GitHub" = {
              urls = [{
                template = "https://github.com/search";
                params = [
                  { name = "q"; value = "{searchTerms}"; }
                ];
              }];
              definedAliases = [ "@github" ];
            };

          };
        };

        bookmarks = [
          { name = "Financial Times"; keyword = "ft"; url = "https://ft.com"; }
          { name = "Github"; keyword = "github"; url = "https://github.com"; }
          { name = "Hacker News"; keyword = "hn"; url = "https://news.ycombinator.com"; }
        ];

        settings = {
          "browser.startup.homepage" = "https://ft.com";
          "browser.contentblocking.category" = "strict";
          "privacy.sanitize.sanitizeOnShutdown" = true;
          "privacy.clearOnShutdown.cookies" = true;
          "privacy.clearOnShutdown.offlineApps" = true;
          "browser.search.suggest.enabled" = false;
          "browser.urlbar.suggest.searches" = false;
          "browser.urlbar.speculativeConnect.enabled" = false;
          "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "app.shield.optoutstudies.enabled" = false;
          "app.normandy.enabled" = false;
          "app.normandy.api_url" = "";
          "breakpad.reportURL" = "";
          "browser.tabs.crashReporting.sendReport" = false;
          "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
          "dom.security.https_only_mode" = true;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.default.sites" = "";
        };
      };
    };
  };
}
