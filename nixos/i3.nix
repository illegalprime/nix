{ config, pkgs, ... }:

{
  imports = [
    ./x.nix
  ];

  environment.systemPackages = with pkgs; [
    compton
    i3-gaps
    nitrogen
    konsole
  ];

  services.xserver.windowManager.i3.package = pkgs.i3-gaps;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3.configFile = ../dotfiles/i3/.config/i3/kde-config;
}

