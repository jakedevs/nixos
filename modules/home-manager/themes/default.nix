{
  inputs,
  lib,
  config,
  ...
}:
{

  imports = [
    ./qt.nix
    ./gtk.nix
  ];
}
