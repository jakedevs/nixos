{ pkgs, ... }:
{
	programs.nixvim = {
  extraPlugins = [ pkgs.vimPlugins."fcitx-vim" ];
	};
}
