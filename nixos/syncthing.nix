{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    user = "michael";
    dataDir = "/home/michael/.syncthing";
    openDefaultPorts = true;
  };

  environment.systemPackages = [
    pkgs.qsyncthingtray
  ];
}
