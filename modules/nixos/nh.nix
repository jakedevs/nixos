{ username, ... }:
{
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep 25";
    flake = "/home/${username}/.config/nixos";
  };
}
