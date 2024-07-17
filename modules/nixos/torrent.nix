{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  options.floodConfig.enable = lib.mkEnableOption "enable floodConfig";

  config = lib.mkIf config.floodConfig.enable {
    services = {
      flood.enable = true;
      transmission = {
        enable = true;
        openRPCPort = true;
        settings."rpc-authentication-required" = false;
      };
    };
  };
}
