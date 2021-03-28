let dunst =
      [ { src = "dunst/dunstrc", dest = "/home/mika/.config/dunst/dunstrc" } ]

let faereld =
      [ { src = "faereld/config.dhall"
        , dest = "/home/mika/.andgeloman/faereld/config.yml"
        }
      ]

let git = [ { src = "git/gitconfig", dest = "/home/mika/.gitconfig" } ]

let haskell =
      [ { src = "haskell/ghci.conf", dest = "/home/mika/.ghc/ghci.conf" } ]

let mail =
      [ { src = "mail/mbsync.dhall", dest = "/home/mika/.mbsyncrc" }
      , { src = "mail/msmtprc.dhall", dest = "/home/mika/.msmtprc" }
      , { src = "mail/signature", dest = "/home/mika/.signature" }
      , { src = "mail/mutt/muttrc", dest = "/home/mika/.mutt/muttrc" }
      , { src = "mail/mutt/mailcap", dest = "/home/mika/.mutt/mailcap" }
      , { src = "mail/mutt/autophagy"
        , dest = "/home/mika/.mutt/accounts/autophagy"
        }
      ]

let nvim =
      [ { src = "nvim/coc-settings.dhall"
        , dest = "/home/mika/.config/nvim/coc-settings.json"
        }
      , { src = "nvim/coc.vim", dest = "/home/mika/.config/nvim/coc.vim" }
      , { src = "nvim/init.vim", dest = "/home/mika/.config/nvim/init.vim" }
      , { src = "nvim/plugin_settings.vim"
        , dest = "/home/mika/.config/nvim/plugin_settings.vim"
        }
      , { src = "nvim/settings.vim"
        , dest = "/home/mika/.config/nvim/settings.vim"
        }
      , { src = "nvim/syntax.vim", dest = "/home/mika/.config/nvim/syntax.vim" }
      ]

let qutebrowser =
      [ { src = "qutebrowser/config.py"
        , dest = "/home/mika/.config/qutebrowser/config.py"
        }
      ]

let terminal =
      [ { src = "terminal/Xresources.dhall", dest = "/home/mika/.Xresources" }
      , { src = "terminal/rgignore", dest = "/home/mika/.rgignore" }
      , { src = "terminal/xinitrc", dest = "/home/mika/.xinitrc" }
      , { src = "terminal/zshrc", dest = "/home/mika/.zshrc" }
      ]

let xmonad =
      [ { src = "xmonad/xmonad.hs", dest = "/home/mika/.xmonad/xmonad.hs" }
      , { src = "xmonad/stack.dhall", dest = "/home/mika/.xmonad/stack.yaml" }
      , { src = "xmonad/build", dest = "/home/mika/.xmonad/build" }
      , { src = "xmonad/lock.nims", dest = "/home/mika/.xmonad/lock.nims" }
      , { src = "xmonad/shell.sh", dest = "/home/mika/.xmonad/shell.sh" }
      , { src = "xmonad/screenlayout.sh"
        , dest = "/home/mika/.xmonad/screenlayout.sh"
        }
      ]

let xmobar = [ { src = "xmobar/xmobarrc.dhall", dest = "/home/mika/.xmobarrc" } ]

let rofi =
      [ { src = "rofi/config.rasi"
        , dest = "/home/mika/.config/rofi/config.rasi"
        }
      , { src = "rofi/theme.dhall", dest = "/home/mika/.config/rofi/theme.rasi" }
      ]

in  { hord =
          dunst
        # faereld
        # git
        # haskell
        # mail
        # nvim
        # qutebrowser
        # terminal
        # xmonad
        # xmobar
        # rofi
    }
