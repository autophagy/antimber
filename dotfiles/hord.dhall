let dunst =
      [ { src = "dunst/dunstrc"
        , dest = "/home/mika/.config/dunst/dunstrc"
        }
      ]

let faereld =
      [ { src = "faereld/config.yml"
        , dest =
            "/home/mika/.andgeloman/faereld/config.yml"
        }
      ]

let git =
      [ { src = "git/gitconfig"
        , dest = "/home/mika/.gitconfig"
        }
      ]

let haskell =
      [ { src = "haskell/ghci.conf"
        , dest = "/home/mika/.ghc/ghci.conf"
        }
      ]

let i3 =
      [ { src = "i3/config"
        , dest = "/home/mika/.config/i3/config"
        }
      , { src = "i3/i3lock.sh"
        , dest = "/home/mika/.config/i3/i3lock.sh"
        }
      , { src = "i3/polybar.sh"
        , dest = "/home/mika/.config/i3/polybar.sh"
        }
      , { src = "i3/shell.sh"
        , dest = "/home/mika/.config/i3/shell.sh"
        }
      ]

let mail =
      [ { src = "mail/mbsyncrc"
        , dest = "/home/mika/.mbsyncrc"
        }
      , { src = "mail/msmtprc"
        , dest = "/home/mika/.msmtprc"
        }
      , { src = "mail/signature"
        , dest = "/home/mika/.signature"
        }
      , { src = "mail/mutt/muttrc"
        , dest = "/home/mika/.mutt/muttrc"
        }
      , { src = "mail/mutt/mailcap"
        , dest = "/home/mika/.mutt/mailcap"
        }
      , { src = "mail/mutt/autophagy"
        , dest =
            "/home/mika/.mutt/accounts/autophagy"
        }
      , { src = "mail/mutt/deadcells"
        , dest =
            "/home/mika/.mutt/accounts/deadcells"
        }
      ]

let nvim =
      [ { src = "nvim/coc-settings.json"
        , dest =
            "/home/mika/.config/nvim/coc-settings.json"
        }
      , { src = "nvim/coc.vim"
        , dest = "/home/mika/.config/nvim/coc.vim"
        }
      , { src = "nvim/init.vim"
        , dest = "/home/mika/.config/nvim/init.vim"
        }
      , { src = "nvim/plugin_settings.vim"
        , dest =
            "/home/mika/.config/nvim/plugin_settings.vim"
        }
      , { src = "nvim/settings.vim"
        , dest =
            "/home/mika/.config/nvim/settings.vim"
        }
      ]

let polybar =
      [ { src = "polybar/config"
        , dest = "/home/mika/.config/polybar/config"
        }
      , { src = "polybar/spotify"
        , dest = "/home/mika/.config/polybar/spotify"
        }
      ]

let qutebrowser =
      [ { src = "qutebrowser/config.py"
        , dest =
            "/home/mika/.config/qutebrowser/config.py"
        }
      ]

let terminal =
      [ { src = "terminal/Xresources"
        , dest = "/home/mika/.Xresources"
        }
      , { src = "terminal/rgignore"
        , dest = "/home/mika/.rgignore"
        }
      , { src = "terminal/xinitrc"
        , dest = "/home/mika/.xinitrc"
        }
      , { src = "terminal/zshrc"
        , dest = "/home/mika/.zshrc"
        }
      ]

in  { hord =
          dunst
        # faereld
        # git
        # haskell
        # i3
        # mail
        # nvim
        # polybar
        # qutebrowser
        # terminal
    }
