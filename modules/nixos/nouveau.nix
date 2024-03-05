{ config, lib, pkgs, input, ... }: {
  boot.initrd.kernelModules = [ "nouveau" ];
  services.xserver.videoDrivers = [ "nouveau" ];
  chaotic.mesa-git.enable = true;
}
