{ user, ... }:
{ config, pkgs, ... }:

{
  virtualisation.virtualbox.host.enable = true;
  users.extraUsers."${user.name}".extraGroups = [ "vboxusers" ];

  networking.hosts = {
    "192.168.99.100" = [ "local.seedco.de" "s3.seedco.de" ];
  };
}
