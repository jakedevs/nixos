{ pkgs, lib, ... }:
{
  imports = [
    ./zsh.nix
    ./fish.nix
    ./hypridle.nix
    ./themes
    ./browsers
  ];
}
