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
      platformTheme.name = "gtk3";
      style.name = "fusion";
    };
  };
}
