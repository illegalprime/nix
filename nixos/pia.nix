{ config, pkgs, ... }:

with builtins;

let
  lib = import <nixpkgs/lib>;
  pia-config = import ./pia-config.nix;
  vpn_str = with lib.strings; file: removeSuffix ".ovpn" (toLower (replaceStrings [" "] ["-"] file));
  pia_username = readFile ./pia-user.txt;
in
{
  environment.systemPackages = with pkgs; [
    openvpn
    networkmanager_openvpn
    openresolv
  ];

  # Configure all our servers
  # Use with `sudo systemctl start openvpn-us-east`
  services.openvpn.servers = foldl' (init: file: init // {
    "${vpn_str file}" = {
      config = readFile "${pia-config}/config/${file}";
      autoStart = false;
      up = "echo nameserver $nameserver | ${pkgs.openresolv}/sbin/resolvconf -m 0 -a $dev";
      down = "${pkgs.openresolv}/sbin/resolvconf -d $dev";
    };
  }) {} (
    attrNames (readDir "${pia-config}/config")
  );

  # Put the same files in `/etc/NetworkManager/` so we can use it there.
  environment.etc = foldl' (init: file:
    with lib.strings;
    let
      config = readFile "${pia-config}/config/${file}";
      uuid = readFile "${pia-config}/uuids/${file}";
      get_match = key: elemAt (match ".*\n${key}[[:space:]]+([^\n]+).*" config) 0;
      read = key: index: elemAt (splitString " " (get_match key)) index;
      proto = if read "proto" 0 == "udp" then "no" else "yes";
    in
    init // {
    "NetworkManager/system-connections/${vpn_str file}" = {
      text = ''
        [connection]
        id=${lib.strings.removeSuffix ".ovpn" file}
        uuid=${uuid}
        type=vpn
        autoconnect=false

        [vpn]
        service-type=org.freedesktop.NetworkManager.openvpn
        username=${pia_username}
        comp-lzo=yes
        remote=${read "remote" 0}
        cipher=${read "cipher" 0}
        auth=${read "auth" 0}
        connection-type=password
        password-flags=1
        port=${read "remote" 1}
        proto-tcp=${proto}
        ca=${read "ca" 0}

        [ipv4]
        method=auto
      '';
      mode = "600";
    };
  }) {} (
    attrNames (readDir "${pia-config}/config")
  );
}
