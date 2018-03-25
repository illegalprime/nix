# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

meta:
{ config, pkgs, ... }:

let
  nvidia = import ./nvidia.nix;
  programming = import ./programming.nix;
  syncthing = import ./syncthing.nix;
  steam = import ./steam.nix;
in
{
  imports = [
    ./power-tune.nix
    (nvidia meta)
    ./hosts.nix
    ./pia-system.nix
    ./cli-tools.nix
    ./fonts.nix
    (programming meta)
    ./latex.nix
    # GUI
    (syncthing meta)
    ./gui-tools.nix
    ./i3.nix
    ./kde.nix
    (steam meta)
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
  networking.hostName = meta.hostname;
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
  time.timeZone = meta.timezone;

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

  #
  # Sound
  #
  # NixOS allows either a lightweight build (default) or full build of
  # PulseAudio to be installed. Only the full build has Bluetooth support.
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  # Docker
  virtualisation.docker.enable = true;

  #
  #
  # Users
  #
  #
  users.extraUsers."${meta.user.name}" = {
    isNormalUser = true;
    home = "/home/${meta.user.name}";
    description = meta.user.full_name;
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
