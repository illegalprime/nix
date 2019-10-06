{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    user = "1000";
    group = "100";
    dataDir = "${config.users.users.me.home}/.syncthing";
    openDefaultPorts = true;
    package = (import (builtins.fetchGit {
      name = "nixpkgs-syncthing-1.2.1";
      url = https://github.com/nixos/nixpkgs/;
      rev = "fd397919368f43facbc867f540549cca729d0e58";
    }) {}).syncthing;
  };

  environment.systemPackages = with pkgs; [
    qsyncthingtray
  ];
}
