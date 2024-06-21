{
  username,
  lib,
  config,
  ...
}:
{

  options.syncthingConfig.enable = lib.mkEnableOption "enable syncthing config";

  config = lib.mkIf config.syncthingConfig.enable {
    syncthing = {
      enable = true;
      user = "${username}";
      dataDir = "/home/${username}/Sync";
      configDir = "/home/${username}/.config/syncthing";
      overrideDevices = true;
      overrideFolders = true;
      settings = {
        # devices = {
        #   "SM-G991U" = {
        #     id = "4XQYBAU-RVG24HB-2FMFRXC-KISKNWJ-CLRFPKV-HLPJM3C-BVTV7VU-7JWBSA5";
        #   };
        # };
        folders = {
          "Sync" = {
            path = "/home/${username}/Sync";
            devices = [ "SM-G991U" ];
          };
          "Notes" = {
            path = "/home/${username}/Notes";
            devices = [ "SM-G991U" ];
          };
        };
        gui = {
          user = "${username}";
          password = "1907";
        };
      };
    };
    home-manager.users.${username} = {
      services.syncthing = {
        enable = true;
        tray.enable = true;
      };
    };
  };
}
