{
  config,
  lib,
  pkgs,
  input,
  ...
}:
{
  options.qtConfig.enable = lib.mkEnableOption "enable qt config";
  config = lib.mkIf config.qtConfig.enable {
    qt = {
      enable = true;
      style.package = pkgs.libsForQt5.breeze-qt5;
      style.name = "kvantum";
    };
  };
}
