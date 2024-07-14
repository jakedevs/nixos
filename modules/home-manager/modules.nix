{ pkgs, lib, ... }:
{
  imports = [
    ./zsh.nix
    ./fish.nix
    ./obs.nix
    ./themes
    ./firefox.nix
    ./emacs.nix
  ];
}
