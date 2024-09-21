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
    ./packages
    ./hyprland
  ];
}
