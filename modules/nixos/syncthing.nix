{
  username,
  lib,
  config,
  ...
}:
{

  options.syncthingConfig.enable = lib.mkEnableOption "enable syncthing config";

  config = lib.mkIf config.syncthingConfig.enable {
    services.syncthing = {
      enable = true;
      user = "${username}";
      dataDir = "/home/${username}/Sync";
      configDir = "/home/${username}/.config/syncthing";
      overrideDevices = true;
      overrideFolders = true;
      settings = {
        devices = {
          "SM-G991U".id = "4XQYBAU-RVG24HB-2FMFRXC-KISKNWJ-CLRFPKV-HLPJM3C-BVTV7VU-7JWBSA5";
          "jake".id = "CA4NFAX-QSQ5KRW-TNS3YMZ-NEWXXXZ-KFU4OLX-HFU4K53-T4NZM4N-DGHAIAY";
          "iberu".id = "MLY6RK6-GBKPJCC-3ZUFL4U-BJA7PRD-RIFCIDA-XCS4VR2-A6HXPV4-FZ7FIQQ";

        };
        folders = {
          "Sync" = {
            path = "/home/${username}/Sync";
            devices = [
              "SM-G991U"
              "jake"
              "iberu"
            ];
          };
        };
        gui = {
          user = "${username}";
          password = "1907";
        };
      };
    };
  };
}
