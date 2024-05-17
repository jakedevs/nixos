{
  config,
  lib,
  pkgs,
  input,
  ...
}:
{
  options.nuConfig.enable = lib.mkEnableOption "enable nushell config";
  config = lib.mkIf config.nuConfig.enable {

    programs = {
      nushell.enable = true;
      zoxide.enable = true;
      yazi.enable = true;
      zoxide.enableNushellIntegration = true;
      yazi.enableNushellIntegration = true;
    };
  };
}
