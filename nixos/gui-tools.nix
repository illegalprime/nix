{ ... }:
{ config, pkgs, ... }:

{

  imports = [
    ./x.nix
    ./firefox.nix
  ];

  environment.systemPackages = with pkgs; [
    xcape
    gimp
    vlc
    baobab
    gparted
    zeal
    libreoffice-fresh
    fritzing
    glxinfo
    dolphinEmuMaster
  ];
}

