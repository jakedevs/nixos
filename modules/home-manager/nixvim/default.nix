{
imports = [
./cmp.nix
];
programs.nixvim = {
enable = true;
luaLoader.enable = true;

colorschemes.kanagawa.enable = true;

plugins = {

treesitter.enable = true;

lualine.enable = true;

conform-nvim.enable = true;

nvim-autopairs.enable = true;

neogit.enable = true;

lsp = {
enable = true;
servers = {
nixd.enable = true;
};
};

luasnip.enable = true;

};
};
}
