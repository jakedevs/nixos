{config, lib, inputs, pkgs, modulesPath, ... }:
{
  imports = [ "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix" ];

  nixpkgs.hostPlatform = "x86_64-linux";

  boot = {
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    supportedFilesystems = {
      bcachefs = true;
    };
  };

  environment.systemPackages = with pkgs; [
    inputs.nixvim.packages.${system}.default
    disko
    git
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
