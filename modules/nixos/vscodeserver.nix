{ pkgs, lib, username, ... }: {
	services.code-server = {
		enable = true;
		disableTelemetry = true;
		user =  username;
	};
}

