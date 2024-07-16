{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    qt6.qtwayland
    libsForQt5.qt5.qtwayland
  ];
}
