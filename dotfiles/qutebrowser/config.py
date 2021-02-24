##   Configfile for qutebrowser.



## Background color of the completion widget category headers.
## Type: QssColor
c.colors.completion.category.bg = "#F2F2F2"

## Bottom border color of the completion widget category headers.
## Type: QssColor
c.colors.completion.category.border.bottom = "#F2F2F2"

## Top border color of the completion widget category headers.
## Type: QssColor
c.colors.completion.category.border.top = "#F2F2F2"

## Foreground color of completion widget category headers.
## Type: QtColor
c.colors.completion.category.fg = "#2D2D2D"

## Background color of the completion widget for even rows.
## Type: QssColor
c.colors.completion.even.bg = "#2D2D2D"

## Text color of the completion widget.
## Type: QtColor
c.colors.completion.fg = "#F2F2F2"

## Background color of the selected completion item.
## Type: QssColor
c.colors.completion.item.selected.bg = "#F2F2F2"

## Background color for hints. Note that you can use a `rgba(...)` value
## for transparency.
## Type: QssColor
c.colors.hints.bg = "#2D2D2D"

## Font color for hints.
## Type: QssColor
c.colors.hints.fg = "#F2F2F2"

## Background color of the statusbar in insert mode.
## Type: QssColor
c.colors.statusbar.insert.bg = "#588F7A"

## Foreground color of the statusbar in insert mode.
## Type: QssColor
c.colors.statusbar.insert.fg = "#FFFFFF"

## Background color of the statusbar.
## Type: QssColor
c.colors.statusbar.normal.bg = "#2D2D2D"

## Foreground color of the statusbar.
## Type: QssColor
c.colors.statusbar.normal.fg = "#F2F2F2"

## Foreground color of the URL in the statusbar on error.
## Type: QssColor
c.colors.statusbar.url.error.fg = "#a62626"

## Default foreground color of the URL in the statusbar.
## Type: QssColor
c.colors.statusbar.url.fg = "#2D2D2D"

## Foreground color of the URL in the statusbar for hovered links.
## Type: QssColor
c.colors.statusbar.url.hover.fg = "#1287a4"

## Foreground color of the URL in the statusbar on successful load
## (http).
## Type: QssColor
c.colors.statusbar.url.success.http.fg = "#2D2D2D"

## Foreground color of the URL in the statusbar on successful load
## (https).
## Type: QssColor
c.colors.statusbar.url.success.https.fg = "#2D2D2D"

## Foreground color of the URL in the statusbar when there's a warning.
## Type: QssColor
c.colors.statusbar.url.warn.fg = "#a27f2b"

## Background color of unselected even tabs.
## Type: QtColor
c.colors.tabs.even.bg = "#111111"

## Foreground color of unselected even tabs.
## Type: QtColor
c.colors.tabs.even.fg = "#A8A8A8"

## Background color of unselected odd tabs.
## Type: QtColor
c.colors.tabs.odd.bg = "#2D2D2D"

## Foreground color of unselected odd tabs.
## Type: QtColor
c.colors.tabs.odd.fg = "#F2F2F2"

## Behavior when the last tab is closed.
## Type: String
## Valid values:
##   - ignore: Don't do anything.
##   - blank: Load a blank page.
##   - startpage: Load the start page.
##   - default-page: Load the default page.
##   - close: Close the window.
c.tabs.last_close = "startpage"

## The page to open if :open -t/-b/-w is used without URL. Use
## `about:blank` for a blank page.
## Type: FuzzyUrl
c.url.default_page = "https://ft.com"

## Definitions of search engines which can be used via the address bar.
## Maps a searchengine name (such as `DEFAULT`, or `ddg`) to a URL with a
## `{}` placeholder. The placeholder will be replaced by the search term,
## use `{{` and `}}` for literal `{`/`}` signs. The searchengine named
## `DEFAULT` is used when `url.auto_search` is turned on and something
## else than a URL was entered to be opened. Other search engines can be
## used by prepending the search engine name to the search term, e.g.
## `:open google qutebrowser`.
## Type: Dict
c.url.searchengines = {
    "g": "https://www.google.de/search?q={}",
    "y": "https://www.youtube.com/results?search_query={}",
    "m": "https://www.google.com/maps/search/{}",
    "h": "https://hoogle.haskell.org/?hoogle={}&scope=set%3Astackage",
    "de:en": "https://www.deepl.com/translator#de/en/{}",
    "en:de": "https://www.deepl.com/translator#en/de/{}",
    "DEFAULT": "https://ecosia.org/search?q={}",
}

## The page(s) to open at the start.
## Type: List of FuzzyUrl, or FuzzyUrl
c.url.start_pages = "https://ft.com"

#  Enable high DPI mode in qt.
c.qt.highdpi = True

## Normal mode bindings

config.bind(',m', 'spawn -d mpv --ytdl-format="bestvideo[height<=?1080]+bestaudio/best" {url}')
config.bind(',a', 'spawn -d mpv --no-video {url}')

## Passthrough mode binding

config.bind('<Ctrl-g>', 'mode-leave', mode='passthrough')

config.load_autoconfig(False)
