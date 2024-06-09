{ pkgs, lib, ... }:

{
  imports = [
    ./disk.nix
    ./nvidia.nix
    ./nouveau.nix
    ./vscodeserver.nix
    ./emacs.nix
    ./hyprland
  ];
}
