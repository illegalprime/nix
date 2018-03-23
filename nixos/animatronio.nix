# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  hostname = "animatronio";
  timezone = "America/New_York";
in
{
  imports = [
    # Include the results of the hardware scan.
    ./animatronio-hardware.nix
    ./power-tune.nix
    ./hosts.nix
    ./cli-tools.nix
    ./fonts.nix
    ./programming.nix
    ./latex.nix
    # GUI
    ./gui-tools.nix
    ./i3.nix
    ./kde.nix
    ./nvidia.nix
    ./steam.nix
  ];

  #
  #
  # Booting
  #
  #
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Supposedly better for the SSD.
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  #
  #
  # Networking
  #
  #
  networking.hostName = hostname;
  networking.firewall.enable = false;
  networking.networkmanager.enable = true;

  #
  #
  # Locality, Time & Font
  #
  #
  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };
  # Set your time zone.
  time.timeZone = timezone;

  #
  #
  # Packages & Services
  #
  #
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [];

  # List services that you want to enable:

  #
  # SSH
  #
  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;

  # Sound
  hardware.pulseaudio.enable = true;

  # Docker
  virtualisation.docker.enable = true;

  #
  #
  # Users
  #
  #
  users.extraUsers.michael = {
    isNormalUser = true;
    home = "/home/michael";
    description = "Michael Eden";
    uid = 1000;
    extraGroups = ["wheel" "people" "networkmanager" "docker"];
  };

  #
  #
  # NixOS Version
  #
  #
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?

  #
  # Disable Lid Close
  #
  # services.logind.lidSwitch = "ignore";
}
