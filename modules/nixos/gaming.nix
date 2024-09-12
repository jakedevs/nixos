{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
{
  options.gamingConfig.enable = lib.mkEnableOption "enable gaming stuff";

  config = lib.mkIf config.gamingConfig.enable {

    environment.systemPackages = with pkgs; [
      er-patcher
      goverlay
      mangohud
      libstrangle
      heroic
      winetricks
    ];
    programs = {
      steam = {
        protontricks.enable = true;
        enable = true;
        gamescopeSession.enable = true;
        extraCompatPackages = with pkgs; [ proton-ge-custom ];
        extraPackages = with pkgs; [ libstrangle ];
      };
      gamemode = {
        enable = true;
        enableRenice = true;
        settings = {
          general.renice = -20;
        };
      };
      gamescope = {
        enable = true;
        capSysNice = true;
        package = pkgs.gamescope_git;
      };
    };
  };
}
