{
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [
    ./nvidia.nix
    ./vscodeserver.nix
    ./syncthing.nix
    ./idle.nix
    ./art.nix
    ./gaming.nix
    ./overlays.nix
    ./nh.nix
    ./packages
    ./hyprland
  ];
}
