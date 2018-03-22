{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    stow
    wget
    curl
    git
    zsh-git-prompt
    zsh
    irssi
    nmap
    screen
    zip
    unzip
    pv
    tig
    ranger
    tree
    jq
    fortune
    cowsay
    ntfs3g
    coreutils
    pciutils
    lshw
    xxd
    inotify-tools
    file
  ];

  programs.command-not-found.enable = true;
}

