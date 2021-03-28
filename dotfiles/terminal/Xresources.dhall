let Colours = ../common/colours.dhall

in ''
Xft.dpi: 96
Xft.autohint: 0
Xft.lcdfilter:  lcddefault
Xft.hintstyle:  hintfull
Xft.hinting: 1
Xft.antialias: 1
Xft.rgba: rgb

! URxvt

! General settings
URxvt.saveLines: 2000
URxvt.scrollBar: False
URxvt.scrollstyle: rxvt
URxvt.urgentOnBell: True
URxvt.cursorBlink: False
URxvt.internalBorder: 25

! Extensions
URxvt.url-launcher: xdg-open
URxvt.matcher.button: 1
URxvt.underlineURLs: True

URxvt.copyCommand:  xclip -i -selection clipboard
URxvt.pasteCommand: xclip -o -selection clipboard

! Fonts
URxvt*font: xft:Inconsolata Nerd Font:size=12:antialias=true:style=Regular, xft:DejaVuSansMono Nerd Font Mono:style=Book:size=10, xft:Symbola:style=Regular:size=12, xft:WenQuanYi Micro Hei Mono,文泉驛等寬微米黑,文泉驿等宽微米黑:style=Regular:size=12
URxvt*letterSpace: 0

! gruvbox (dark)
! special
*.foreground:   ${Colours.foreground}
*.background:   ${Colours.background}
*.cursorColor:  ${Colours.foreground}

! black
*.color0:       #282828
*.color8:       #928374

! red
*.color1:       #cc241d
*.color9:       #fb4934

! green
*.color2:       #98971a
*.color10:      #b8bb26

! yellow
*.color3:       #d79921
*.color11:      #fabd2f

! blue
*.color4:       #458588
*.color12:      #83a598

! magenta
*.color5:       #b16286
*.color13:      #d3869b

! cyan
*.color6:       #689d6a
*.color14:      #8ec07c

! white
*.color7:       #a89984
*.color15:      #ebdbb2

urxvt*perl-lib:         /usr/lib/urxvt/perl/
urxvt*perl-ext-common:  default,matcher
''
