{ config, lib, pkgs, input, ... }: {
  programs = {
    fish.enable = true;
    fish.interactiveShellInit = ''
      set fish_greeting # Disable greeting
      set -g async_prompt_functions _pure_prompt_git
    '';
    fish.plugins = [
      { name = "pure"; src = pkgs.fishPlugins.pure.src; }
      { name = "fish-async-prompt"; src = pkgs.fishPlugins.async-prompt.src; }
    ];

    zoxide.enable = true;
    zoxide.enableFishIntegration = true;

    shellAliases = {
      neofetch = "fastfetch";
      ngit = "nvim -c 'Neogit kind=replace'";
      ".ngit" = "yadm enter nvim -c Neogit -c bw1";
      nixup = "sudo nixos-rebuild switch --flake '/home/jake/.config/nixos#default'";
      nixboot = "sudo nixos-rebuild boot --flake '/home/jake/.config/nixos#default'";
      nixnew = "cd /home/jake/.config/nixos && sudo nix flake update && cd";
      fm = "ya";
    };

    programs.eza.enable = true;
    programs.eza.icons = true;
    programs.eza.enableAliases = true;

  };
}
