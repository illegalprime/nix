let
  meta = {
    graphics = {
      driver = "nvidia";
      pci = "01:00.0";
    };
  };
in
{ config, pkgs, pkgs_i686, ... }:
{
  #
  # Graphics
  #
  nixpkgs.config.allowUnfree = true;
  # hardware.opengl.driSupport32Bit = true;
  # hardware.bumblebee.enable = true;
  # hardware.bumblebee.connectDisplay = true;
  # services.xserver.videoDrivers = [ "nvidia" "intel" ];
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.driSupport32Bit = true;
  hardware.nvidia.optimus_prime.enable = true;
  hardware.nvidia.optimus_prime.nvidiaBusId = "PCI:1:0:0";
  hardware.nvidia.optimus_prime.intelBusId = "PCI:0:2:0";

  services.tlp.extraConfig = if config.services.tlp.enable then
  ''
    RUNTIME_PM_BLACKLIST="${meta.graphics.pci}"
    RUNTIME_PM_DRIVER_BLACKLIST="amdgpu nouveau nvidia radeon"
  ''
  else "";
}
else
{ config, pkgs, ... }: {}

