{ user, ... }:
{ config, pkgs, ... }:

{
  imports = [
    ./emacs.nix
  ];

  # Lanuages n' other things I use
  environment.systemPackages = with pkgs; [
    neovim
    # GUI Stuff
    atom
  ];

  # ADB Setup
  programs.adb.enable = true;
  users.users."${user.name}".extraGroups = ["adbusers"];
}

