{ inputs, pkgs, ... }:
{
  services = {
    flood.enable = true;
    transmission = {
      enable = true;
      openRPCPort = true;
      settings."rpc-authentication-required" = false;
    };
  };
}
