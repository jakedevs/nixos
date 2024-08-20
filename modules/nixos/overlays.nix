{
  inputs,
  config,
  pkgs,
  ...
}:
{
  nixpkgs.overlays = [
    # inputs.hyprpanel.overlay."x86_64-linux"
    inputs.blender-bin.overlays.default
    inputs.nur.overlay
  ];
  environment.systemPackages = with pkgs; [
    blender_4_2
    # hyprpanel
  ];
}
