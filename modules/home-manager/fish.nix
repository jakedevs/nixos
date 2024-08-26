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
        nixup = "nixos-rebuild --use-remote-sudo switch --flake '/home/${username}/.config/nixos#${username}' --log-format multiline-with-logs";
        nixboot = "nixos-rebuild --use-remote-sudo boot --flake '/home/${username}/.config/nixos#${username}' --log-format multiline-with-logs";
        nixnew = "cd /home/${username}/.config/nixos && sudo nix flake update  --log-format multiline-with-logs && cd -";
        nixclean = "sudo nix-collect-garbage -d --log-format multiline-with-logs";
        nixi = "nixos-rebuild --use-remote-sudo test --flake '/home/${username}/.config/nixos/#${username}' --fast --log-format multiline-with-logs";
        nixtest = "nixos-rebuild --use-remote-sudo test --flake '/home/${username}/.config/nixos/#${username}' --log-format multiline-with-logs";
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
