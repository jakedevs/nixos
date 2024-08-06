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
    ./packages
    ./hyprland
  ];
}
