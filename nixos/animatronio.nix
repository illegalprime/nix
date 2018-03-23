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
};

configuration = import ./configuration.nix;
in
{
  imports = [
    # Include the results of the hardware scan.
    ./animatronio-hardware.nix
    (configuration meta)
  ];

  #
  # HACK: Change if you have LVM
  #
  systemd.services.systemd-udev-settle.enable = false;
}
