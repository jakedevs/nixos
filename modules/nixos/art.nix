{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  options.artConfig.enable = lib.mkEnableOption "graphics tablet and art applications";

  config = lib.mkIf config.artConfig.enable {
    hardware.opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };

    environment.systemPackages = with pkgs; [
      rnote
      krita
    ];
  };
}
