{ pkgs, lib, ... }: {
  services.openvscode-server = {
    enable = true;
    user = "jake";
    userDataDir = "/home/jake/.config/openvscode-server";
    telemetryLevel = "off";
    withoutConnectionToken = true;
    extraPackages = with pkgs; [ git neovim rustup fish nix ];
  };
}

