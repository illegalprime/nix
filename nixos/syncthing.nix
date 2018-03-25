{ user, ... }:
{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    user = user.name;
    dataDir = "/home/${user.name}/.syncthing";
    openDefaultPorts = true;
  };

  environment.systemPackages = [
    pkgs.qsyncthingtray
  ];
}
