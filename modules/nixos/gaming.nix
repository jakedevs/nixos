{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.gamingConfig.enable = lib.mkEnableOption "enable gaming stuff";

  config = lib.mkIf config.gamingConfig.enable {
    environment.systemPackages = with pkgs; [
      goverlay
      mangohud
      libstrangle
      heroic
    ];
    programs = {
      steam = {
        enable = true;
        extraCompatPackages = with pkgs; [ proton-ge-bin ];
        extraPackages = with pkgs; [ libstrangle ];
      };
      gamemode = {
        enable = true;
        enableRenice = true;
        settings = {
          general.renice = -20;
        };
      };
    };
  };
}
