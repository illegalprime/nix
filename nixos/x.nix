{ config, pkgs, ... }:

{
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;
    layout = "us";
    xkbOptions = "ctrl:nocaps";

    # Touchpad
    libinput = {
      enable = true;
      naturalScrolling = true;
      middleEmulation = false;
      tapping = true;
      disableWhileTyping = true;
      additionalOptions = ''
        Option "TappingButtonMap" "lrm"
      '';
    };
  };
}

