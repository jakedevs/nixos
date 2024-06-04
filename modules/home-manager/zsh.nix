{
  config,
  lib,
  pkgs,
  input,
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
        nixup = "sudo nixos-rebuild switch --flake '/home/jake/.config/nixos#jake'";
        nixboot = "sudo nixos-rebuild boot --flake '/home/jake/.config/nixos#jake'";
        nixnew = "cd /home/jake/.config/nixos && sudo nix flake update && cd -";
        nixclean = "sudo nix-collect-garbage -d";
        nixvim = "cd /home/jake/.config/nixos && sudo nix flake lock --update-input nixvim && cd -";
        nixiso = "cd /home/jake/.config/nixos && nix build ./#nixosConfigurations.buildIso.config.system.build.isoImage && cd -";
        nixquick = "sudo nixos-rebuild test --flake '/home/jake/.config/nixos/#jake' --fast";
        nixtest = "sudo nixos-rebuild test --flake '/home/jake/.config/nixos/#jake'";
        bible = "rustup doc --book";
        fm = "ya";
        fhs = "nix-shell --run fish /home/jake/.config/nixos/modules/nixos/fhs.nix";
        vis = "vi -S";
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

    programs.zoxide.enable = true;
    programs.zoxide.enableZshIntegration = true;

    programs.eza.enable = true;
    programs.eza.icons = true;
    programs.eza.enableZshIntegration = true;
  };
}
