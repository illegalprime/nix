{ ... }:
{ pkgs, config, ... }:

{
  imports = [
    ./x.nix
  ];

  #
  # Awesome WM
  #
  services.xserver.windowManager.awesome.enable = true;
}
