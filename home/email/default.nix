_:

{
  imports = [ ./neomutt.nix ./immerok.nix ];

  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
}
