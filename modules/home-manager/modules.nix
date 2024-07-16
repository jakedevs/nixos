{ pkgs, lib, ... }:
{
  imports = [
    ./zsh.nix
    ./fish.nix
    ./obs.nix
    ./themes
    ./firefox
    ./emacs.nix
  ];
}
