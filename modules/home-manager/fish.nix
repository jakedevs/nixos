{
  config,
  lib,
  pkgs,
  input,
  ...
}:
{
  programs = {
    fish.enable = true;
    fish.interactiveShellInit = ''
            set fish_greeting
            set -g async_prompt_functions _pure_prompt_git
            set fish_color_command green
            set fish_color_error red --bold
            fish_vi_key_bindings
      			nix-your-shell fish | source
    '';
    fish.plugins = [
      {
        name = "pure";
        src = pkgs.fishPlugins.pure.src;
      }
      {
        name = "fish-async-prompt";
        src = pkgs.fishPlugins.async-prompt.src;
      }
    ];

    fish.functions = {
      nix-shell = "nix-your-shell fish nix-shell -- $argv end";
      nix = "nix-your-shell fish nix -- $argv";
    };

    zoxide.enable = true;
    zoxide.enableFishIntegration = true;

    fish.shellAliases = {
      neofetch = "fastfetch";
      ngit = "nvim -c 'Neogit kind=replace'";
      ".ngit" = "yadm enter nvim -c Neogit -c bw1";
      nixup = "sudo nixos-rebuild switch --flake '/home/jake/.config/nixos#jake'";
      nixboot = "sudo nixos-rebuild boot --flake '/home/jake/.config/nixos#jake'";
      nixnew = "cd /home/jake/.config/nixos && sudo nix flake update && cd -";
      nixclean = "sudo nix-collect-garbage -d";
      nixvim = "cd /home/jake/.config/nixos && sudo nix flake lock --update-input nixvim && cd -";
      nixiso = "cd /home/jake/.config/nixos && nix build ./#nixosConfigurations.buildIso.config.system.build.isoImage && cd -";
      nixquick = "sudo nixos-rebuild test --flake '/home/jake/.config/nixos/#jake' --fast";
      nixtest = "sudo nixos-rebuild test --flake '/home/jake/.config/nixos/#jake'";
      fm = "ya";
      fhs = "nix-shell --run fish /home/jake/.config/nixos/modules/nixos/fhs.nix";
      vis = "vi -S";
    };

    yazi.enable = true;
    yazi.enableFishIntegration = true;

    eza.enable = true;
    eza.icons = true;
    eza.enableFishIntegration = true;
  };
}
