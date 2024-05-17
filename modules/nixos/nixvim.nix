
{ pkgs, lib, inputs, ... }:

{
  environment.systemPackages = [
      inputs.nixvim.packages."x86_64-linux".default
  ];
}
