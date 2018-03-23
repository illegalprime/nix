meta:
{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    user = meta.user.name;
    dataDir = "/home/${meta.user.name}/.syncthing";
    openDefaultPorts = true;
  };

  environment.systemPackages = [
    pkgs.qsyncthingtray
  ];
}
