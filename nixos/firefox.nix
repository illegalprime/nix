{ config, pkgs, ... }:

{
  environment.systemPackages =
  if config.services.xserver.enable then with pkgs; [
    firefox
  ]
  else [];
}

