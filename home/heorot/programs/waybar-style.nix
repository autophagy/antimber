{ common, ... }:

''
  * {
      /* `otf-font-awesome` is required to be installed for icons */
      font-family: Inconsolata Nerd Font Mono;
      font-size: 14px;
  }

  window#waybar {
      background-color: ${common.colours.background};
      border-bottom: 0px;
      color: ${common.colours.foreground};
      transition-property: background-color;
      transition-duration: .5s;
  }

  window#waybar.hidden {
      opacity: 0.2;
  }

  button {
      /* Use box-shadow instead of border so the text isn't offset */
      box-shadow: inset 0 -3px transparent;
      /* Avoid rounded borders under each button name */
      border: none;
      border-radius: 0;
  }

  /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
  button:hover {
      background: inherit;
      box-shadow: inset 0 -3px #ffffff;
  }

  #workspaces button {
      padding: 0 5px;
      background-color: transparent;
      color: ${common.colours.foreground};
  }

  #workspaces button:hover {
      background: rgba(0, 0, 0, 0.2);
  }

  #workspaces button.focused {
      background-color: transparent;
      box-shadow: inset 0 -3px ${common.colours.bgFgBlended};
  }

  #workspaces button.urgent {
      background-color: #eb4d4b;
  }

  #clock,
  #battery,
  #cpu,
  #memory,
  #disk,
  #temperature,
  #backlight,
  #network,
  #pulseaudio,
  #wireplumber,
  #custom-media,
  #tray,
  #mode,
  #idle_inhibitor,
  #scratchpad,
  #power-profiles-daemon,
  #mpd {
      padding: 0 10px;
      background-color: transparent;
      color: ${common.colours.foreground};
      border-bottom: 0px;
  }

  #window,
  #workspaces {
      margin: 0 4px;
  }

  /* If workspaces is the leftmost module, omit left margin */
  .modules-left > widget:first-child > #workspaces {
      margin-left: 0;
  }

  /* If workspaces is the rightmost module, omit right margin */
  .modules-right > widget:last-child > #workspaces {
      margin-right: 0;
  }

  #battery.charging, #battery.plugged {
      color: #26A65B;
  }

  @keyframes blink {
      to {
          color: ${common.colours.foreground};
      }
  }

  /* Using steps() instead of linear as a timing function to limit cpu usage */
  #battery.critical:not(.charging) {
      color: ${common.colours.alert};
      animation-name: blink;
      animation-duration: 1s;
      animation-timing-function: steps(12);
      animation-iteration-count: infinite;
      animation-direction: alternate;
  }

  label:focus {
      background-color: #000000;
  }

  #pulseaudio.muted {
      color: ${common.colours.bgFgBlended};
  }
''
