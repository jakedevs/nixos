{ ... }:
{
  syncthing = {
    enable = true;
    user = "jake";
    dataDir = "/home/jake/Sync";
    configDir = "/home/jake/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        "SM-G991U" = {
          id = "4XQYBAU-RVG24HB-2FMFRXC-KISKNWJ-CLRFPKV-HLPJM3C-BVTV7VU-7JWBSA5";
        };
      };
      folders = {
        "Sync" = {
          path = "/home/jake/Sync";
          devices = [ "SM-G991U" ];
        };
        "Notes" = {
          path = "/home/jake/Notes";
          devices = [ "SM-G991U" ];
        };
      };
      gui = {
        user = "jake";
        password = "1907";
      };
    };
  };
}
