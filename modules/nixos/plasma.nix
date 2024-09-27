{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{

  options.plasmaConfig.enable = lib.mkEnableOption "enable plasma config";

  config = lib.mkIf config.plasmaConfig.enable {
    environment.plasma5.excludePackages = with pkgs.libsForQt5; [
      plasma-browser-integration
    ];

    services = {
      desktopManager.plasma6.enable = true;
      displayManager.sddm.enable = true;
      displayManager.sddm.wayland.enable = true;
    };

    environment.systemPackages = with pkgs; [
      kdePackages.yakuake
      kdePackages.sddm-kcm

      #Archiving
      p7zip
      unzip
      zip
      unrar
      gnutar
      bzip2
      bzip3
      gzip
    ];
  };

}
