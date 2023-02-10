_:

{
  services = {
    openssh = {
      enable = true;
      passwordAuthentication = false;
      kbdInteractiveAuthentication = false;
    };
    tailscale.enable = true;
    jellyfin.enable = true;
  };
}

