_:
{
  programs.gpg = {
    enable = true;
    scdaemonSettings = {
      disable-ccid = true;
      pcsc-shared = true;
      disable-application = "piv";
    };
  };

  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    enableSshSupport = true;
    enableScDaemon = true;
  };
}
