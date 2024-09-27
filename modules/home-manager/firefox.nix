{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
{

  options.firefoxConfig.enable = lib.mkEnableOption "enable firefox config";

  config = lib.mkIf config.firefoxConfig.enable {

    home.sessionVariables = {
      MOZ_WEBRENDER = 1;
      MOZ_DISABLE_RDD_SANDBOX = 1;
      LIBVA_DRIVER_NAME = "nvidia";
      NVD_BACKEND = "direct";
      MOZ_ENABLE_WAYLAND = 1;
    };

    programs.firefox = {

      package = inputs.firefox.packages.${pkgs.system}.firefox-nightly-bin;

      enable = true;

      profiles.default = {

        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          bitwarden
          fastforwardteam
          youtube-recommended-videos
          translate-web-pages
          darkreader
        ];

        settings = {
          # Remove exit buttons in titlebar
          "browser.tabs.inTitlebar" = 0;
          "browser.startup.homepage" = "about:blank";
          "browser.startup.page" = 0;
          "browser.newtabpage.enabled" = false;
          "xpsinstall.signatures.required" = false;

          "gfx.webrender.all" = true;
          "layers.acceleration.force-enabled" = true;

          # Middle click scroll
          "general.autoScroll" = true;
          "middlemouse.paste" = false;

          "extensions.pocket.enabled" = false;
          "identity.fxaccounts.enabled" = true;

          "browser.privatebrowsing.vpnpromourl" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        };
      };

    };
  };
}
