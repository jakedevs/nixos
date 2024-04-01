{ config, lib, pkgs, input, ... }: {
  qt = {
    enable = true;
    style.package = pkgs.kdePackages.breeze;
		style.name = "breeze";
  };
}
