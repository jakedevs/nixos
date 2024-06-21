{
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [
    ./nvidia.nix
    ./nouveau.nix
    ./vscodeserver.nix
    ./secops.nix
    ./emacs.nix
    ./gaming.nix
    ./syncthing.nix
    ./idle.nix
    ./packages
    ./hyprland
  ];
}
