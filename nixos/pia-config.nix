with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "pia-config";

  buildInputs = [
    unzip
    libuuid
  ];

  src = fetchurl {
    url = "https://www.privateinternetaccess.com/openvpn/openvpn.zip";
    sha256 = "6f899ff3a040be09499c90091f1f91859487ab176c54c610f6d4be2c74e5f32f";
  };

  unpackPhase = ''
    unzip $src
  '';

  installPhase = ''
    mkdir -p "$out/uuids"
    ls *.ovpn | while read FILE; do
      uuidgen --md5 -n @url -N "$FILE" > "$out/uuids/$FILE"
    done

    mkdir -p "$out/config"
    mv *.ovpn "$out/config"

    mkdir -p "$out/certs"
    mv *.crt *.pem "$out/certs"
  '';

  fixupPhase = ''
    sed -i "s|crl.rsa.2048.pem|$out/certs/\0|g" "$out"/config/*.ovpn
    sed -i "s|ca.rsa.2048.crt|$out/certs/\0|g" "$out"/config/*.ovpn
  '';
}
