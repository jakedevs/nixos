{pkgs, lib, ...}: {
	imports = [
	./zsh.nix
	./fish.nix
	./nushell.nix
	./pass.nix
	./themes
	./browsers
	./hyprland
	./packages/util.nix
	./helix.nix
	];
	}
