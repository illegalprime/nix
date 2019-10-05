{ ... }:
{ config, pkgs, ... }:

{
  imports = [
    ./x.nix
  ];

  environment.systemPackages = with pkgs; [
    compton
    i3-gaps
    nitrogen
    # konsole
  ];

  services.xserver.windowManager.i3 = {
    package = pkgs.i3-gaps;
    enable = true;
    configFile = ../dotfiles/i3/.config/i3/kde-config;
  };

  # Get GTK3 settings to work
  programs.dconf.enable = true;
  services.dbus.packages = [ pkgs.gnome3.dconf ];

  # # Enable compton on startup
  # services.compton = {
  #   enable = true;
  #   extraOptions = builtins.readFile ../dotfiles/compton/.config/compton.conf;
  # };
}

