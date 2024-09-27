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
    ./overlays.nix
    ./gaming.nix
    ./plasma.nix
    ./packages
    ./hyprland
  ];
}
