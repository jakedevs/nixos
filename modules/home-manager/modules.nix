{ pkgs, lib, ... }:
{
  imports = [
    ./zsh.nix
    ./fish.nix
    ./obs.nix
    ./themes
    ./firefox.nix
    ./firefox-nightly.nix
    ./emacs.nix
  ];
}
