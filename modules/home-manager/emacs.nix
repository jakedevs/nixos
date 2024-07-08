{
  pkgs,
  config,
  lib,
  username,
  ...
}:
{
  options.emacsConfig.enable = lib.mkEnableOption "enable emacs config";

  config = lib.mkIf config.emacsConfig.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs29-pgtk;
      extraPackages =
        epkgs: with epkgs; [
          # jinx
          # vterm
        ];
    };

    services.emacs = {
      enable = true;
      client.enable = true;
      package = pkgs.emacs29-pgtk;
    };

    home.packages = with pkgs; [
      emacsPackages.vterm
      emacsPackages.jinx
      enchant
      nuspell
      pkg-config

      hunspellDicts.en_US-large

      # Dependencies
      cmake
      gnumake
      clang
      ispell
      wmctrl
      aria2
      python311Packages.pycookiecheat
      nodejs_22

      # python3
      # python311Packages.epc
      # python311Packages.orjson
      # python311Packages.sexpdata
      # python311Packages.six
      # python311Packages.setuptools
      # python311Packages.paramiko
      # python311Packages.rapidfuzz
    ];
  };
}
