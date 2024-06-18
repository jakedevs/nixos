{
  pkgs,
  config,
  lib,
  ...
}:
{
  options.emacsConfig.enable = lib.mkEnableOption "enable emacs config";

  config = lib.mkIf config.emacsConfig.enable {
    services.emacs = {
      enable = true;
      startWithGraphical = true;
      install = true;
      package = pkgs.emacs29-pgtk;
    };
    environment.systemPackages = with pkgs; [
      emacsPackages.vterm

      # Dependencies
      cmake
      gnumake
      clang
      libtool
    ];
  };
}
