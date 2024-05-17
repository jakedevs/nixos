{ pkgs, lib, ... }:

{
  imports = [
    ./disk.nix
    ./nvidia.nix
    ./nouveau.nix
  ];
}
