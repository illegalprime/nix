{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    emacs

    # fast grep
    silver-searcher

    ## Flyspell
    aspell
    aspellDicts.en
  ];

  # Enable emacs service
  services.emacs.enable = true;
}

