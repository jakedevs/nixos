{ pkgs, lib, ... }:

{
  imports = [
    ./nvidia.nix
    ./nouveau.nix
    ./vscodeserver.nix
    ./hyprland
  ];
}
