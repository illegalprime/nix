# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  meta =
{
  hostname = "animatronio";
  user = {
    name = "michael";
    full_name = "Michael Eden";
  };
  graphics = {
    driver = "nvidia";
    pci = "01:00.0";
  };
  timezone = "America/New_York";
  pia-systemd = {
    enable = true;
    credentials = null;
  };
  pia-nm = {
    enable = true;
    user = "p2223201";
  };
  gui.enable = true;
  battery.enable = true;
  desktop = {
    i3.enable = true;
    kde.enable = true;
  };
};
in
{
  imports = [
    # Include the results of the hardware scan.
    ./animatronio-hardware.nix
    (import ./configuration.nix meta)
  ];

  #
  # HACK: Change if you have LVM
  #
  systemd.services.systemd-udev-settle.enable = false;
}
