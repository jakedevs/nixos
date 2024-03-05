{ inputs, pkgs, ... }: {
  wayland.windowManager.hyprland = {

    enable = true;

    settings = {
      "source" = "~/.config/hyprland.conf";
    };

  };
}
