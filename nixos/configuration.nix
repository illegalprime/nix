meta:
{ config, pkgs, ... }:

let import_if = cond: path: if cond then import path meta else {...}:{}; in
{
  imports = [
    # Default (Servers)
    ./hosts.nix
    ./cli-tools.nix

    # DMs/WMs
    (import_if meta.desktop.i3.enable ./i3.nix)
    (import_if meta.desktop.kde.enable ./kde.nix)
    (import_if meta.desktop.awesome.enable ./awesome.nix)

    # For Desktops
    (import_if meta.gui.enable ./fonts.nix)
    (import_if meta.gui.enable ./programming.nix)
    (import_if meta.gui.enable ./latex.nix)
    (import_if meta.gui.enable ./syncthing.nix)
    (import_if meta.gui.enable ./gui-tools.nix)
    # (import_if meta.gui.enable ./steam.nix)

    # For Laptops
    (import_if meta.battery.enable ./power-tune.nix)

    # VPN Stuff
    (import_if meta.pia-systemd.enable ./pia-system.nix)
    (import_if meta.pia-nm.enable ./pia-nm.nix)

    # Nvidia Card
    # (import_if (meta.graphics.driver == "nvidia") ./nvidia.nix)

    # QEMU Cross-Native-Compiling
    ./qemu.nix
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
  system.stateVersion = "19.03"; # Did you read the comment?

  #
  # Disable Lid Close
  #
  # services.logind.lidSwitch = "ignore";
}
