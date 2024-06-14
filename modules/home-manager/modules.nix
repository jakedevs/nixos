{ pkgs, lib, ... }:
{
  imports = [
    ./zsh.nix
    ./fish.nix
    ./themes
    ./browsers
    ./packages
  ];
}
