let
  heorot = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICIdbr5D6l66CFklBLi1Dl8ybAlEPu6k7Ve6B+Z+itZO mail@autophagy.io";
  hindberige = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKHcaqrV9w3oNX6VgU3XFNv2lQ2u6CBEFh+qm/hjFpHx root@nixos";
  keys = [ heorot hindberige ];
in
{
  "forebodere.age".publicKeys = keys;
  "vaultwarden.age".publicKeys = keys;
  "email.notifications.age".publicKeys = keys;
}
