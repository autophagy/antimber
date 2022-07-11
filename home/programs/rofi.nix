{ config, pkgs, ... }:
let
  themePath = ".config/rofi/theme.rasi";
  common = import ../common.nix;
  prompt = "λ";
in
{
  programs.rofi = {
    enable = true;
    extraConfig.modi = "drun";
    theme = "~/${themePath}";
  };

  home.file."${themePath}".text = ''
    * {
        font:                        "Inconsolata 12";
        selected-normal-foreground:  @background;
        foreground:                  ${common.colours.foreground};
        normal-foreground:           @foreground;
        alternate-normal-background: #00000000;
        red:                         rgba ( 220, 50, 47, 100 % );
        selected-urgent-foreground:  rgba ( 239, 97, 85, 100 % );
        blue:                        rgba ( 38, 139, 210, 100 % );
        urgent-foreground:           rgba ( 239, 97, 85, 100 % );
        alternate-urgent-background: rgba ( 47, 30, 46, 18 % );
        active-foreground:           rgba ( 129, 91, 164, 100 % );
        lightbg:                     rgba ( 238, 232, 213, 100 % );
        selected-active-foreground:  rgba ( 129, 91, 164, 100 % );
        alternate-active-background: rgba ( 47, 30, 46, 18 % );
        background:                  ${common.colours.background}CC;
        bordercolor:                 rgba ( 235, 219, 178, 100 % );
        alternate-normal-foreground: @foreground;
        normal-background:           #00000000;
        lightfg:                     rgba ( 88, 104, 117, 100 % );
        selected-normal-background:  @foreground;
        border-color:                @bordercolor;
        spacing:                     2;
        separatorcolor:              rgba ( 235, 219, 178, 100 % );
        urgent-background:           rgba ( 47, 30, 46, 15 % );
        selected-urgent-background:  rgba ( 129, 91, 164, 33 % );
        alternate-urgent-foreground: @urgent-foreground;
        background-color:            rgba ( 0, 0, 0, 0 % );
        alternate-active-foreground: @active-foreground;
        active-background:           rgba ( 47, 30, 46, 15 % );
        selected-active-background:  rgba ( 129, 91, 164, 33 % );
    }

    #window {
        background-color: @background;
        border:           2;
        padding:          30;
        width:            40%;
        height:           350px;
    }
    #mainbox {
        border:  0;
        padding: 0;
    }
    #message {
        border:       1px dash 0px 0px ;
        border-color: @separatorcolor;
        padding:      1px ;
    }
    #textbox {
        text-color: @foreground;
    }
    #listview {
        fixed-height: 0;
        border:       2px dash 0px 0px ;
        border-color: @separatorcolor;
        spacing:      2px ;
        scrollbar:    true;
        padding:      15px 0px 0px ;
    }
    #element-text {
        border:  0;
        padding: 1px ;
    }
    #element-text.normal.normal {
        background-color: @normal-background;
        text-color:       @normal-foreground;
    }
    #element-text.normal.urgent {
        background-color: @urgent-background;
        text-color:       @urgent-foreground;
    }
    #element-text.normal.active {
        background-color: @active-background;
        text-color:       @active-foreground;
    }
    #element-text.selected.normal {
        background-color: @selected-normal-background;
        text-color:       @selected-normal-foreground;
    }
    #element-text.selected.urgent {
        background-color: @selected-urgent-background;
        text-color:       @selected-urgent-foreground;
    }
    #element-text.selected.active {
        background-color: @selected-active-background;
        text-color:       @selected-active-foreground;
    }
    #element-text.alternate.normal {
        background-color: @alternate-normal-background;
        text-color:       @alternate-normal-foreground;
    }
    #element-text.alternate.urgent {
        background-color: @alternate-urgent-background;
        text-color:       @alternate-urgent-foreground;
    }
    #element-text.alternate.active {
        background-color: @alternate-active-background;
        text-color:       @alternate-active-foreground;
    }
    #scrollbar {
        width:        4px ;
        border:       0;
        handle-width: 8px ;
        padding:      0;
    }
    #mode-switcher {
        border:       2px dash 0px 0px ;
        border-color: @separatorcolor;
    }
    #button.selected {
        background-color: @selected-normal-background;
        text-color:       @selected-normal-foreground;
    }
    #inputbar {
        spacing:    0;
        text-color: @normal-foreground;
        padding:    0px 0px 15px 0px ;
    }
    #case-indicator {
        spacing:    0;
        text-color: @normal-foreground;
    }
    #entry {
        spacing:    0;
        text-color: @normal-foreground;
    }
    #prompt {
        spacing:    0;
        text-color: @normal-foreground;
    }
    #inputbar {
        children:   [ textbox-prompt-colon,entry,case-indicator ];
    }
    #textbox-prompt-colon {
        expand:     false;
        str:        "${prompt} ";
        margin:     0px 0.3em 0em 0em ;
        text-color: @normal-foreground;
    }
  '';
}
