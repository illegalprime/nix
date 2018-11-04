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

  #
  # Hacks to get Anaconda Mode working w/ emacs
  nixpkgs.config.packageOverrides = pkgs: rec {
    emacs = pkgs.emacs.overrideDerivation (args: rec {
      # Use gtk3 instead of the default gtk2
      withGTK3 = true;
      withGTK2 = false;

      # Make sure imagemgick is a dependency because I regularly
      # look at pictures from Emasc
      imagemagick = pkgs.imagemagickBig;

      pythonPath = [];
      buildInputs = with pkgs; (args.buildInputs ++
      [
        makeWrapper
        python
        python36Packages.setuptools
        python3Packages.pip
        python3Packages.ipython
        python3Packages.numpy
      ]);

      postInstall = with pkgs.python27Packages; (args.postInstall + ''
      echo "This is PYTHONPATH: " $PYTHONPATH
      wrapProgram $out/bin/emacs \
      --prefix PYTHONPATH : "$(toPythonPath ${python}):$(toPythonPath ${ipython}):$(toPythonPath ${setuptools}):$(toPythonPath ${pip}):$(toPythonPath ${numpy}):$PYTHONPATH";
      '');
    });
  };
}

