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
      gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
      enable = true;
      theme = {
        name = "Kanagawa-BL";
        package = pkgs.kanagawa-gtk-theme;
      };

      iconTheme = {
        name = "Tela-dracula-dark";
        package = pkgs.tela-icon-theme;
      };
    };

    # home.pointerCursor = {
    #   x11.enable = true;
    #   gtk.enable = true;
    #   package = pkgs.google-cursor;
    #   name = "GoogleDot-Blue";
    #   size = 24;
    # };

    home.packages = with pkgs; [ glib ];
  };
}
