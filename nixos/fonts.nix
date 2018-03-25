{ ... }:
{ config, pkgs, ... }:

{
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
}

