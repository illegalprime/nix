{ config, pkgs, ... }:

{
  imports = [
    ./x.nix
  ];

  environment.systemPackages = with pkgs; [
    compton
    nitrogen
  ];

  services.xserver.windowManager.i3 = {
    package = pkgs.i3-gaps;
    enable = true;
    configFile = ../dotfiles/i3/.config/i3/kde-config;
  };
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.windowManager.default = "i3";

  # Get GTK3 settings to work
  programs.dconf.enable = true;
  services.dbus.packages = [ pkgs.gnome3.dconf ];

  # # Enable compton on startup
  # services.compton = {
  #   enable = true;
  #   extraOptions = builtins.readFile ../dotfiles/compton/.config/compton.conf;
  # };
}

