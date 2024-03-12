{ config, lib, pkgs, input, ... }: {
  qt = {
    enable = true;
    platformTheme = "qtct";
    style.package = pkgs.materia-kde-theme;
  };
}
