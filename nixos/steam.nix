{ config, pkgs, ... }:

{
  #
  # Steam
  #
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    steam
  ];

  hardware = {
    opengl.driSupport32Bit = true;
    pulseaudio.support32Bit = true;
    steam-hardware.enable = true;
  };

  boot.kernelModules = [ "uinput" ];
}
