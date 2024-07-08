{ pkgs, lib, ... }:
{
  imports = [
    ./zsh.nix
    ./fish.nix
    ./themes
    ./firefox.nix
    ./emacs.nix
  ];
}
