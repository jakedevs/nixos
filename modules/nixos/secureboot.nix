{ inputs, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ sbctl ];
}
