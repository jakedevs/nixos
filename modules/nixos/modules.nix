{ pkgs, lib, ... }:

{
  imports = [
    ./nvidia.nix
    ./nouveau.nix
    ./vscodeserver.nix
    ./emacs.nix
    ./hyprland
  ];
}
