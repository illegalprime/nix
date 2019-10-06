{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # CLI tools
    stow
    wget
    curl
    zsh-git-prompt
    zsh
    git
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

    # GUI tools
    xcape
    gimp
    vlc
    baobab
    gparted
    zeal
    firefox
  ];

  programs.zsh.enable = true;

  # fonts
  fonts.fonts = with pkgs; [
    source-code-pro
    emojione
    fira-code
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code-symbols
    mplus-outline-fonts
    dina-font
    proggyfonts
  ];

  programs.command-not-found.enable = true;
}
