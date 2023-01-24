{ pkgs, common, ... }:

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
      n = "https://search.nixos.org/packages?channel=${common.versions.nix}&from=0&size=50&sort=relevance&query={}";
      DEFAULT = "https://www.google.de/search?q={}";
    };

    settings = {
      colors = {
        completion.category.bg = common.colours.foreground;
        completion.category.border.bottom = common.colours.foreground;
        completion.category.border.top = common.colours.foreground;
        completion.category.fg = common.colours.background;
        completion.even.bg = common.colours.background;
        completion.fg = common.colours.foreground;
        completion.item.selected.bg = common.colours.background;
        completion.item.selected.fg = common.colours.foreground;
        hints.bg = common.colours.foreground;
        hints.fg = common.colours.background;
        statusbar.insert.bg = "#588F7A";
        statusbar.insert.fg = "#FFFFFF";
        statusbar.normal.bg = common.colours.background;
        statusbar.normal.fg = common.colours.foreground;
        statusbar.url.error.fg = "#a62626";
        statusbar.url.fg = common.colours.foreground;
        statusbar.url.hover.fg = "#1287a4";
        statusbar.url.success.http.fg = common.colours.foreground;
        statusbar.url.success.https.fg = common.colours.foreground;
        statusbar.url.warn.fg = "#a27f2b";
        tabs.even.bg = "#111111";
        tabs.even.fg = common.colours.bgFgBlended;
        tabs.odd.bg = common.colours.background;
        tabs.odd.fg = common.colours.bgFgBlended;
        tabs.selected.even.bg = common.colours.background;
        tabs.selected.odd.bg = common.colours.background;
        tabs.selected.even.fg = common.colours.foreground;
        tabs.selected.odd.fg = common.colours.foreground;
      };
      tabs.last_close = "startpage";
      url = {
        default_page = "https://ft.com";
        start_pages = "https://ft.com";
      };
    };
  };
}
