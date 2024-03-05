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

  };
}
