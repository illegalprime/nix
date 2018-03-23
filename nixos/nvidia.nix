meta:

if meta.graphics.driver == "nvidia" then
{ config, pkgs, ... }:

{
  #
  # Graphics
  #
  nixpkgs.config.allowUnfree = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.bumblebee.enable = true;

  services.tlp.extraConfig = if config.services.tlp.enable then
  ''
    RUNTIME_PM_BLACKLIST="${meta.graphics.pci}"
    RUNTIME_PM_DRIVER_BLACKLIST="amdgpu nouveau nvidia radeon"
  ''
  else "";
}
else
{ config, pkgs, ... }: {}

