{
  pkgs,
  inputs,
  username,
  ...
}:
{
  imports = [
    inputs.nixvim.nixosModules.nixvim
    ./lsp.nix
    ./cmp.nix
    ./mini.nix
    ./keymaps.nix
    ./options.nix
    ./fcitx5.nix
  ];

  programs.nixvim = {

		performance = {
			byteCompileLua = {
				enable = true;
				nvimRuntime = true;
				plugins = false;
			};
			combinePlugins.enable = true;
			# combinePlugins.standalonePlugins = [
			# 	"nvim-treesitter"
			# ];
		}; 

    enable = true;
    defaultEditor = true;
    enableMan = true;

    colorschemes.kanagawa = {
      enable = true;
      settings.compile = true;
    };

    globals.mapleader = " ";

    viAlias = true;
    vimAlias = true;
    luaLoader.enable = true;

    plugins = {

      rustaceanvim.enable = true;

      toggleterm.enable = true;

      bufferline.enable = true;

      comment.enable = true;

      diffview.enable = true;

      lualine.enable = true;
      lualine.globalstatus = true;

      nvim-autopairs.enable = true;
      ts-autotag.enable = true;

      which-key.enable = true;

      nvim-tree.enable = true;

      neogit.enable = true;
      neogit.settings.auto_show_console = false;
      neogit.settings.integrations.diffview = true;
      neogit.settings.integrations.telescope = true;

      telescope.enable = true;

      treesitter.enable = true;
      treesitter.settings.indent.enable = true;

      trouble.enable = true;

      tmux-navigator.enable = true;
    };

  };
}
