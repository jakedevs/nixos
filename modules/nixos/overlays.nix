{
  inputs,
  config,
  pkgs,
  ...
}:
{
  nixpkgs.overlays = [
    inputs.hyprpanel.overlay
    inputs.blender-bin.overlays.default
    inputs.nur.overlay
  ];
  environment.systemPackages = with pkgs; [
    blender_4_2
    hyprpanel
  ];
}
