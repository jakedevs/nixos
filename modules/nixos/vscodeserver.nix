{
  pkgs,
  lib,
  username,
  config,
  ...
}:
{

  options.codeServer.enable = lib.mkEnableOption "enable VScode server";
  config = lib.mkIf config.codeServer.enable {
    services.code-server = {
      enable = true;
      disableTelemetry = true;
      user = username;
    };
  };
}
