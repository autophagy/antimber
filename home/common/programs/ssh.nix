_: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      hindberige = {
        hostname = "hindberige.autophagy.io";
        user = "mika";
        extraOptions.SetEnv = "TERM=xterm-256color";
      };
    };
  };
}
