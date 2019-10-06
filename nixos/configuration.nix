{ config, lib, pkgs, ... }:
{
  imports = [
    # Tools
    ./misc-tools.nix

    # DMs/WMs
    ./x.nix
    ./i3.nix
    ./kde.nix

    # For Desktops
    ./programming.nix
    ./syncthing.nix
    ./steam.nix

    # For Laptops
    ./power-tune

    # VPN Stuff
    # ./pia/pia-system.nix
    ./pia/pia-nm.nix

    # Nvidia Card
    # ./nvidia.nix

    # QEMU Cross-Native-Compiling
    ./qemu.nix
  ];

  #
  # Booting
  #
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Supposedly better for the SSD.
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  #
  # Networking
  #
  networking.firewall.enable = false;
  networking.networkmanager.enable = true;

  #
  # Locality, Time & Font
  #
  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = lib.mkDefault "America/New_York";

  #
  # Filesystems
  #
  boot.supportedFilesystems = ["exfat" "ext4" "nfs"];

  # Use Sandboxing
  nix.useSandbox = true;

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
  virtualisation.docker.enableOnBoot = false;

  #
  # GPG
  #
  programs.gnupg.agent.enable = true;

  #
  # Users
  #
  users.users.me = {
    uid = 1000;
    isNormalUser = true;
    extraGroups = ["wheel" "people" "networkmanager" "docker"];
  };
  users.mutableUsers = false;

  #
  # Plymouth
  #
  boot.plymouth.enable = true;
  boot.plymouth.logo = pkgs.fetchurl {
    url = https://nixos.org/logo/nixos-logo-only-hires.png;
    sha256 = "0j3bsx52lgacgbaslry2v3mqmv0v75cn11akdfjplr09pbl8av8s";
  };
}
