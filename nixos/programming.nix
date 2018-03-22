{ config, pkgs, ... }:

{
  imports = [
    ./emacs.nix
  ];

  # Lanuages n' other things I use
  environment.systemPackages = with pkgs; [
    neovim
    nodejs-slim-8_x
    yarn
    rustc
    cargo
    python3
    ruby
    ocaml
    julia
    elixir
    ghc
    # GUI Stuff
    atom
  ];

  # ADB Setup
  programs.adb.enable = true;
  users.users.michael.extraGroups = ["adbusers"];
}

