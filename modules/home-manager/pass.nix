{ pkgs, ... }: {
  home.packages = with pkgs; [ bitwarden-desktop bitwarden-cli ];

	programs.rbw = {
		enable = true;
	};

}
