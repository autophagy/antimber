{ config, pkgs, ... }:

{
  home.packages = with pkgs.python39Packages; [
    adblock
  ];

  programs.qutebrowser = {
    enable = true;

    searchEngines = {
      y = "https://www.youtube.com/results?search_query={}";
      m = "https://www.google.com/maps/search/{}";
      h = "https://hoogle.haskell.org/?hoogle={}&scope=set%3Astackage";
      n = "https://search.nixos.org/packages?channel=21.05&from=0&size=50&sort=relevance&query={}";
      DEFAULT = "https://www.google.de/search?q={}";
    };

    settings = {
      tabs = {
        last_close = "startpage";
      };
      url = {
        default_page = "https://ft.com";
        start_pages = "https://ft.com";
      };
    };
  };
}
