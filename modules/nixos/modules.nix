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
    ./gaming.nix
    ./syncthing.nix
    ./neovim.nix
    ./idle.nix
    ./art.nix
    ./packages
    ./hyprland
  ];
}
