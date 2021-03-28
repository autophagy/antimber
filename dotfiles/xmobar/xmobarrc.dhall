let Colours = ../common/colours.dhall

in ''
Config { font = "xft:Inconsolata Nerd Font:size=9:antialias=true:style=Regular"
        , additionalFonts = [ "xft:DejaVuSansMono Nerd Font Mono:style=Book:size=8" ]
        , borderColor = "${Colours.background}"
        , border = TopB
        , bgColor = "${Colours.background}"
        , fgColor = "${Colours.foreground}"
        , position = TopSize L 100 25
        , commands =    [ Run Cpu ["-t", "CPU <total>%"] 10
                        , Run Memory ["-t","MEM <usedratio>%"] 10
                        , Run Date "%_d %b %Y // %H.%M" "date" 10
                        , Run StdinReader
                        , Run Com "pamixer" ["--get-volume"] "volume" 5
                        ]
        , sepChar = "!"
        , alignSep = "}{"
        , template = "  <fn=1>∀</fn> !StdinReader! }{ !cpu! | !memory! | !volume!% | !date!  "
        }
''
