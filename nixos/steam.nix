{ config, pkgs, ... }:

{
  #
  # Steam
  #
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.packageOverrides = superPkgs: {
    steam = superPkgs.steam.override {
      withPrimus = true;
      extraPkgs = p: with p; [
        glxinfo        # for diagnostics
        nettools       # for `hostname`, which some scripts expect
        bumblebee      # for optirun
      ];
    };
  };

  users.users.michael.packages = [
    pkgs.steam
  ];

  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;
}
