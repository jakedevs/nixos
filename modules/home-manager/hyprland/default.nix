{ inputs, pkgs, ... }: {

	home.packages = with pkgs; [  
    hyprpaper
    hyprpicker
		hyprlock
	];

  wayland.windowManager.hyprland = {
    enable = true;

    package = inputs.hyprland.packages.${pkgs.system}.hyprland;

    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
    ];

    settings = {
      "source" = "~/.config/nixos/modules/home-manager/hyprland/hyprland.conf";
    };

  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    configPackages = [ pkgs.xdg-desktop-portal-hyprland ];
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];
  };
}
