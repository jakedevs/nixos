{
  config,
  lib,
  pkgs,
  input,
  ...
}:
{

  options.gtkConfig.enable = lib.mkEnableOption "enable gtk config";

  config = lib.mkIf config.gtkConfig.enable {
    gtk = {
      enable = true;
      theme = {
        name = "Andromeda";
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
  };
}
