{config, ...}:let
  helpers = config.lib.nixvim;
in{
	programs.nixvim = {
  keymaps = [
    {
      action = "<cmd>NvimTreeToggle<CR>";
      key = "<leader>e";
      options.silent = true;
      options.desc = "toggle tree";
    }
    {
      action = "<cmd>ObsidianToday<CR>";
      key = "<leader>ot";
      options.silent = true;
      options.desc = "daily note";
    }
    {
      action = "<cmd>ObsidianQuickSwitch<CR>";
      key = "<leader>os";
      options.silent = true;
      options.desc = "search notes";
    }
    {
      action = "<cmd>Telescope live_grep<CR>";
      key = "<leader>fs";
      options.silent = true;
      options.desc = "search text";
    }
    {
      action = "<cmd>Telescope fd<CR>";
      key = "<leader>fd";
      options.silent = true;
      options.desc = "search files";
    }
    {
      action = "<cmd>TroubleToggle<CR>";
      key = "<leader>ce";
      options.silent = true;
      options.desc = "error panel";
    }
    {
      action =  helpers.mkRaw "MiniFiles.open";
      key =  "<leader>fm";
      options.silent = true;
      options.desc = "file manager";
    }
    {
      action = helpers.mkRaw "require ('conform').format";
      key = "<C-S-i>";
      options.desc = "format code";
    }
    {
      action = "<cmd>Neogit<CR>";
      key = "<leader>gg";
      options.desc = "git ui";
    }
    {
      action = "<cmd>bprevious<CR>";
      key = "<leader>h";
    }
    {
      action = "<cmd>bnext<CR>";
      key = "<leader>l";
    }
    {
      action = "<cmd>ToggleTerm direction=tab<CR>";
      key = "<leader>tt";
      options.desc = "terminal tab";
    }
    {
      action = "<cmd>ToggleTerm direction=float<CR>";
      key = "<leader>tf";
      options.desc = "terminal floating panel";
    }
    {
      action = "<cmd>ToggleTerm direction=vertical<CR>";
      key = "<leader>tv";
      options.desc = "terminal vertical split";
    }
    {
      action = "<cmd>ToggleTerm direction=horizontal<CR>";
      key = "<leader>th";
      options.desc = "terminal horizontal split";
    }
  ];
};
}
