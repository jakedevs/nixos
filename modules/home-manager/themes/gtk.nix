{ config, lib, pkgs, input, ... }: {
  gtk = {
    enable = true;
    theme = {
      name = "Andromeda-gtk";
      package = pkgs.callPackage ./andromeda-gtk-theme { };
    };

    iconTheme = {
      name = "Tela";
      package = pkgs.tela-icon-theme;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.google-cursor;
    name = "GoogleDot-Blue";
    size = 24;
  };

}
