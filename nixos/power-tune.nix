{ ... }:
{ config, pkgs, ... }:

{
  #
  # Power Tuning
  #
  environment.systemPackages = [
    pkgs.powertop
    pkgs.iw
  ];

  # Setup custom power-tuning at startup
  systemd.services.power-tune = {
    # slow boot times with this, will investigate if TLP is a replacement
    enable = false;
    description = "Power Management Tune-up";
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "oneshot";

    script = ''
      export POWERTOP_CMD="${pkgs.powertop}/bin/powertop"
      export IW_CMD="${pkgs.iw}/bin/iw"
      /bin/sh ${./power-tune.sh}
    '';
  };

  # TLP power tuning
  services.tlp.enable = true;
}
