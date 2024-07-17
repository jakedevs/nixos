{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.passConfig.enable = lib.mkEnableOption "enable password management config";

  config = lib.mkIf config.passConfig.enable {
    home.packages = with pkgs; [
      bitwarden-desktop
      bitwarden-cli
    ];

    programs.rbw = {
      enable = true;
    };
  };
}
