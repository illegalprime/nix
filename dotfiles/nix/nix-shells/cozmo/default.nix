with import <nixpkgs> {};
with pkgs.python3Packages;

stdenv.mkDerivation {
  name = "cozmo-sdk";
  buildInputs = [
    # these packages are required for virtualenv and pip to work:
    python3Full
    python3Packages.virtualenv
    python3Packages.pip
    # extra packages for cozmo
    python3Packages.pillow
    python3Packages.matplotlib
    python3Packages.numpy
    python3Packages.scikitlearn
    python3Packages.tkinter
    python3Packages.scipy
    zlib
  ];

  src = null;

  shellHook = ''
  # set SOURCE_DATE_EPOCH so that we can use python wheels
  SOURCE_DATE_EPOCH=$(date +%s)
  virtualenv --no-setuptools venv
  export PATH=$PWD/venv/bin:$PATH
  pip install -r requirements.txt
  '';
}
