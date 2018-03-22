{ config, pkgs, ... }:

{
  #
  # Hosts
  #
  networking.extraHosts = ''
    128.61.105.52 calculon
  '';
}
