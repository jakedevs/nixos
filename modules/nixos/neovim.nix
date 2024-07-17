{
  lib,
  inputs,
  pkgs,
  username,
  config,
  ...
}:
{

  options.neovimConfig.enable = lib.mkEnableOption "enable neovim config";

  config = lib.mkIf config.neovimConfig.enable {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };

    # environment.systemPackages = with pkgs; [
    #   luajitPackages.luarocks_bootstrap
    #   luajit
    #   unzip
    # ];

    home-manager.users.${username} = {
      programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;

        extraPackages = with pkgs; [
          luajitPackages.luarocks_bootstrap
          luajit
          unzip
          gcc
        ];
      };
    };
  };
}
