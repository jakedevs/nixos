{ config, lib, pkgs, input, ... }: {
  programs = {
    nushell.enable = true;
    zoxide.enableNushellIntegration = true;
    yazi.enableNushellIntegration = true;

    nushell.shellAliases = {
      neofetch = "fastfetch";
      ngit = "nvim -c 'Neogit kind=replace'";
      ".ngit" = "yadm enter nvim -c Neogit -c bw1";
      nixup = "sudo nixos-rebuild switch --flake '/home/jake/.config/nixos#default'";
      nixboot = "sudo nixos-rebuild boot --flake '/home/jake/.config/nixos#default'";
      nixnew = "cd /home/jake/.config/nixos && sudo nix flake update && cd";
      fm = "ya";
    };
  };
}
