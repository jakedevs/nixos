{
  config,
  lib,
  pkgs,
  username,
  ...
}:
{

  options.fishConfig.enable = lib.mkEnableOption "enable fish config";

  config = lib.mkIf config.fishConfig.enable {
    home.packages = with pkgs; [ nix-your-shell ];
    programs = {
      fish.enable = true;
      fish.interactiveShellInit = ''
              set fish_greeting
              set -g async_prompt_functions _pure_prompt_git
              set fish_color_command green
              set fish_color_error red --bold
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
        nixup = "sudo nixos-rebuild switch --flake '/home/${username}/.config/nixos#${username}'";
        nixboot = "sudo nixos-rebuild boot --flake '/home/${username}/.config/nixos#${username}'";
        nixnew = "cd /home/${username}/.config/nixos && sudo nix flake update && cd -";
        nixclean = "sudo nix-collect-garbage -d";
        nixi = "sudo nixos-rebuild test --flake '/home/${username}/.config/nixos/#${username}' --fast";
        nixtest = "sudo nixos-rebuild test --flake '/home/${username}/.config/nixos/#${username}'";
        bible = "rustup doc --book";
        fm = "yy";
      };

      yazi.enable = true;
      yazi.enableFishIntegration = true;

      eza.enable = true;
      eza.icons = true;
      eza.enableFishIntegration = true;
    };
  };
}
