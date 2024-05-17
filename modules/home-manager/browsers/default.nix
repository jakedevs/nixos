{ pkgs, lib, ... }:
{
  imports = [
    ./firefox.nix
    ./librewolf.nix
  ];
}
