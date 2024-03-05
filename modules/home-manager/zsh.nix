{ config, lib, pkgs, input, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;

    shellAliases = {
      neofetch = "fastfetch";
      ngit = "nvim -c 'Neogit kind=replace'";
      ".ngit" = "yadm enter nvim -c Neogit -c bw1";
      nixup = "sudo nixos-rebuild switch --flake '/home/jake/.config/nixos#default'";
      nixboot = "sudo nixos-rebuild boot --flake '/home/jake/.config/nixos#default'";
      nixnew = "cd /home/jake/.config/nixos && sudo nix flake update";
      fm = "ya";
    };

    antidote.enable = true;
    antidote.plugins = [ "zsh-users/zsh-autosuggestions" "zsh-users/zsh-completions" "zsh-users/zsh-history-substring-search" "zsh-users/zsh-syntax-highlighting" "Aloxaf/fzf-tab" "mafredri/zsh-async" "sindresorhus/pure" ];
  };

  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;

  programs.eza.enable = true;
  programs.eza.icons = true;
  programs.eza.enableAliases = true;
}
