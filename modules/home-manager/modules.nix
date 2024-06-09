{ pkgs, lib, ... }:
{
  imports = [
    ./zsh.nix
    ./fish.nix
    ./themes
    ./browsers
    # ./hyprland
    ./packages/util.nix
    # ./helix.nix
  ];
}
