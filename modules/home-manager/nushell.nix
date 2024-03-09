{ config, lib, pkgs, input, ... }: {
  programs = {
    nushell.enable = true;
    zoxide.enable = true;
    yazi.enable = true;
    zoxide.enableNushellIntegration = true;
    yazi.enableNushellIntegration = true;
  };
}
