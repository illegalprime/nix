# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

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
    enable = false;
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
    awesome.enable = true;
  };
};
in
{
  imports = [
    # Include the results of the hardware scan.
    ./animatronio-hardware.nix
    (import ./configuration.nix meta)

    (import /home/michael/cde/kde/nixpkgs/nixos/modules/services/ofono/default.nix {
      pkgs = pkgs // { ofono = (import /home/michael/cde/kde/nixpkgs {}).ofono; };
      inherit config lib;
    })

    (import ./tulip.nix meta)
  ];


  #
  # HACK: Change if you have LVM
  #
  systemd.services.systemd-udev-settle.enable = false;

  #
  # Change if you like it
  #
  # services.keybase.enable = true;
  # services.kbfs.enable = true;

  services.mongodb.enable = true;

  boot.blacklistedKernelModules = [
    "psmouse"
  ];

  # systemd.services.postgresql.enable = true;

  boot.supportedFilesystems = [
    "exfat"
    "ext4"
  ];

  #
  # Ofono, plasma mobile testing
  #
  # services.ofono = {
  #   enable = true;
  #   plugins.phonesim.enable = true;
  # };

  # Get TeamViewer running for Mack Molding
  # services.teamviewer.enable = true;

  # nix.useSandbox = true;

  # HackGT NFC Readers
  services.pcscd.enable = true;
}
