{ config, lib, pkgs, input, ... }: {
  gtk = {
    enable = true;
    theme = {
      name = "Andromeda-gtk";
      package = pkgs.andromeda-gtk-theme;
    };

    iconTheme = {
      name = "Tela";
      package = pkgs.tela-icon-theme;
    };
  };

  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    package = pkgs.google-cursor;
    name = "GoogleDot-Blue";
    size = 24;
  };

}
