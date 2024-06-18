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
    ./packages
    ./hyprland
  ];
}
