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
      platformTheme.name = "gtk";
      style.name = "gtk2";
    };
  };
}
