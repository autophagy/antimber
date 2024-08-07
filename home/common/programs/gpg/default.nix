{ pkgs, ... }:
{
  programs.gpg = {
    enable = true;
    scdaemonSettings = {
      disable-ccid = true;
      pcsc-shared = true;
      disable-application = "piv";
    };
    publicKeys = [
      {
        source = ./autophagy.pub;
        trust = "ultimate";
      }
    ];
  };

  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    enableSshSupport = true;
    enableScDaemon = true;
    pinentryPackage = pkgs.pinentry-qt;
  };

  home.file.".gnupg/sshcontrol".text = ''
    BF37F1F88381DCB1704D07DF06106ACAAA3845C6
  '';
}
