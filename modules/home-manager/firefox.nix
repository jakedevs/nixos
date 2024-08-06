{
  lib,
  pkgs,
  config,
  ...
}:
{

  options.firefoxConfig.enable = lib.mkEnableOption "enable firefox config";

  config = lib.mkIf config.firefoxConfig.enable {

    programs.firefox = {

      package = pkgs.firefox-bin;

      enable = true;

      profiles.default = {

        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          bitwarden
          fastforwardteam
          youtube-recommended-videos
          translate-web-pages
          darkreader
          decentraleyes
        ];

        settings = {
          # Remove exit buttons in titlebar
          "browser.tabs.inTitlebar" = 0;

          # Middle click scroll
          "general.autoScroll" = true;

          # Disable FF sync and Pocket
          "extensions.pocket.enabled" = false;
          "identity.fxaccounts.enabled" = true;
          "middlemouse.paste" = false;
        };
      };

    };
  };
}
