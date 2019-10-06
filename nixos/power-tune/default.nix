{ config, pkgs, ... }:

{
  # Setup custom power-tuning at startup
  systemd.services.power-tune = {
    # slow boot times with this, will investigate if TLP is a replacement
    enable = false;
    description = "Power Management Tune-up";
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "oneshot";

    script = "${./power-tune.sh}";
    path = with pkgs; [ bash powertop iw ];
  };

  # TLP power tuning
  services.tlp.enable = true;
}
