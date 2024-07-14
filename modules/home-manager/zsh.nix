{
  config,
  lib,
  pkgs,
  input,
  username,
  ...
}:
{
  options.zshConfig.enable = lib.mkEnableOption "enable zsh config";

  config = lib.mkIf config.zshConfig.enable {

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autocd = true;

      shellAliases = {
        neofetch = "fastfetch";
        ngit = "nvim -c 'Neogit kind=replace'";
        ".ngit" = "yadm enter nvim -c Neogit -c bw1";
        nixup = "sudo nixos-rebuild switch --flake '/home/${username}/.config/nixos#${username}'";
        nixboot = "sudo nixos-rebuild boot --flake '/home/${username}/.config/nixos#${username}'";
        nixnew = "cd /home/${username}/.config/nixos && sudo nix flake update && cd -";
        nixclean = "sudo nix-collect-garbage -d";
        nixvim = "cd /home/${username}/.config/nixos && sudo nix flake lock --update-input nixvim && cd -";
        nixiso = "cd /home/${username}/.config/nixos && nix build ./#nixosConfigurations.buildIso.config.system.build.isoImage && cd -";
        nixquick = "sudo nixos-rebuild test --flake '/home/${username}/.config/nixos/#${username}' --fast";
        nixtest = "sudo nixos-rebuild test --flake '/home/${username}/.config/nixos/#${username}'";
        bible = "rustup doc --book";
        fm = "yazi";
      };

      antidote.enable = true;
      antidote.plugins = [
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-completions"
        "zsh-users/zsh-history-substring-search"
        "zsh-users/zsh-syntax-highlighting"
        "Aloxaf/fzf-tab"
        "mafredri/zsh-async"
        "sindresorhus/pure"
      ];
    };

    programs = {

      zoxide.enable = true;
      zoxide.enableZshIntegration = true;

      eza.enable = true;
      eza.icons = true;
      eza.enableZshIntegration = true;
    };

  };
}
