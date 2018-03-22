{ config, pkgs, ... }:

{
  #
  # LaTeX
  #
  environment.systemPackages = with pkgs; [
    texlive.combined.scheme-medium
    pandoc
  ];
}
