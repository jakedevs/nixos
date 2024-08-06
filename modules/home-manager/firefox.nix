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

      package = pkgs.firefox-devedition-bin;

      enable = true;

      profiles.dev-edition-default = {

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
          "browser.startup.homepage" = "about:blank";
          "xpsinstall.signatures.required" = false;

          "gfx.webrender.all" = true;
          "layers.acceleration.force-enabled" = true;

          # Middle click scroll
          "general.autoScroll" = true;
          "middlemouse.paste" = false;

          "extensions.pocket.enabled" = false;
          "identity.fxaccounts.enabled" = true;
        };
      };

    };
  };
}
