{ resolver = "lts-17.7"
, flags.xmobar.all_extensions = True
, extra-deps = [ "netlink-1.1.1.0" ]
, packages = [ "xmobar-git", "xmonad-git", "xmonad-contrib-git" ]
}
