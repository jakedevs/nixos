{ pkgs, lib, username, ... }: {
	services.code-server = {
		enable = false;
		disableTelemetry = true;
		user =  username;
	};
}

