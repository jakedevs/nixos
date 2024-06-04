{ pkgs, lib, ... }: {
	services.code-server = {
		enable = true;
		disableTelemetry = true;
		user = "jake";
	};
}

