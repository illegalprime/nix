{
  allowUnfree = true;
  services.keybase.enable = true;

  firefox.enableAdobeFlash = true;

  sandbox = true;

  packageOverrides = pkgs: {
    # New Konsole w/ D-Bus stuff
    konsole = pkgs.konsole.overrideAttrs (oldAttrs: rec {
      src = /home/michael/cde/kde/konsole;
      version = "474c06d5a5ec35c3395763406d88c49dff723b6e";
      name = "konsole-master";

      buildInputs = oldAttrs.buildInputs ++ (with pkgs.libsForQt5; [
        knewstuff
      ]);

      meta.priority = 4;
    });

    # New Okular w/ D-Bus stuff
    okular = pkgs.okular.overrideAttrs (oldAttrs: rec {
      src = /home/michael/cde/kde/okular;
      version = "18.04.1";
      name = "okular-18.04.1";

      buildInputs = oldAttrs.buildInputs ++ (with pkgs.libsForQt5; [
        kcrash
      ]);
    });

    # All the support we want
    qemu = pkgs.qemu.overrideAttrs (oldAttrs: rec {
      spiceSupport = true;
      usbredirSupport = true;
      virglSupport = true;
      openGLSupport = true;

      configureFlags = oldAttrs.configureFlags ++ [
        "--enable-gtk"
        "--with-gtkabi=3.0"
        "--enable-kvm"
        "--enable-spice"
        "--enable-usb-redir"
        "--enable-virglrenderer"
        "--enable-opengl"
      ];

      buildInputs = oldAttrs.buildInputs ++ (with pkgs; [
        gnome3.gtk gettext gnome3.vte # gtk support
        mesa_noglu epoxy libdrm # opengl support
        virglrenderer # virgl support
      ]);
    });

    # Enable 64-bit support in wine
    wine = pkgs.wine.override {
      wineBuild = "wineWow";
    };
  };
}
