{ config, pkgs, ... }:

{
  #
  # Graphics
  #
  nixpkgs.config.allowUnfree = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.bumblebee.enable = true;
}
