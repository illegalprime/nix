{ config, pkgs, ... }:

{
  imports = [
    ./x.nix
  ];

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.desktopManager.default = "plasma5";

  # Packages to help!
  environment.systemPackages = with pkgs; [
    qt5.qttools
    kwallet-pam
    ksshaskpass
    kdeFrameworks.kwallet
    kdeApplications.kwalletmanager
    redshift-plasma-applet
  ];
}

