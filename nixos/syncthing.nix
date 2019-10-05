{ user, ... }:
{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    user = user.name;
    dataDir = "/home/${user.name}/.syncthing";
    openDefaultPorts = true;
    package = (import (builtins.fetchGit {
      name = "nixpkgs-syncthing-1.2.1";
      url = https://github.com/nixos/nixpkgs/;
      rev = "fd397919368f43facbc867f540549cca729d0e58";
    }) {}).syncthing;
  };

  environment.systemPackages = [
    pkgs.qsyncthingtray
  ];
}
