_:
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      hindberige = {
        hostname = "hindberige.faun-basilisk.ts.net";
        user = "mika";
        extraOptions.SetEnv = "TERM=xterm-256color";
      };
    };
  };
}
