# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./animatronio-hardware.nix
    ./configuration.nix
  ];

  # Hostname
  networking.hostName = "animatronio";

  # Username
  users.users.me = {
    name = "michael";
    description = "Michael Eden";
    hashedPassword = "$6$ws4vHuTBA7zm6c.X$0tjzfSqqjKCmBXlchi8GSVeyc2sFghxDDQNhn4t.T3znyPIh6hEuQBYYDxkfP2ztfCwkRtctUpACgMSeyIxx/.";
  };

  #
  # HACK: Change if you have LVM
  #
  systemd.services.systemd-udev-settle.enable = false;

  #
  # Change if you like it
  #
  services.keybase.enable = true;
  services.kbfs.enable = true;

  boot.blacklistedKernelModules = [
    "psmouse"
  ];


  # HackGT NFC Readers
  services.pcscd.enable = true;

  #
  # FlatPak
  #
  services.flatpak.enable = true;

  #
  # QEMU Compiling
  #
  qemu-user.arm = true;
  qemu-user.aarch64 = true;

  # chili plasma theme
  environment.systemPackages = with pkgs; [
    (callPackage ./sddm-theme-chili.nix {})
  ];
  services.xserver.displayManager.sddm.theme = "plasma-chili";

  #
  #
  # NixOS Version
  #
  #
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
