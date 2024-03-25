{ config, lib, pkgs, input, ... }: {
  programs = {
    fish.enable = true;
    fish.interactiveShellInit = ''
      set fish_greeting
      set -g async_prompt_functions _pure_prompt_git
      set fish_color_command green
      set fish_color_error red --bold
      fish_vi_key_bindings
    '';
    fish.plugins = [
      { name = "pure"; src = pkgs.fishPlugins.pure.src; }
      { name = "fish-async-prompt"; src = pkgs.fishPlugins.async-prompt.src; }
    ];

    zoxide.enable = true;
    zoxide.enableFishIntegration = true;

    fish.shellAliases = {
      neofetch = "fastfetch";
      ngit = "nvim -c 'Neogit kind=replace'";
      ".ngit" = "yadm enter nvim -c Neogit -c bw1";
      nixup = "sudo nixos-rebuild switch --flake '/home/jake/.config/nixos#main'";
      nixboot = "sudo nixos-rebuild boot --flake '/home/jake/.config/nixos#main'";
      nixnew = "cd /home/jake/.config/nixos && sudo nix flake update && cd -";
      nixclean = "sudo nix-collect-garbage -d";
      nixvim = "cd /home/jake/.config/nixos && sudo nix flake lock --update-input nixvim && cd";
      fm = "ya";
			fhs = "nix-shell --run fish /home/jake/.config/nixos/modules/nixos/fhs.nix";
    };

    yazi.enable = true;
    yazi.enableFishIntegration = true;

    eza.enable = true;
    eza.icons = true;
    eza.enableFishIntegration = true;

  };
}
