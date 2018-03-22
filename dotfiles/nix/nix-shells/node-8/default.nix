with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "node-8";
  buildInputs = with pkgs; [
    nodejs-slim-8_x
    yarn
  ];

  src = null;
}
