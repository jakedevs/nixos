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

    home.file = {
      "tridactylrc".source = ./tridactylrc;
      "tridactylrc".target = "/home/jake/.config/tridactyl/tridactylrc";
    };

    xdg.desktopEntries = {
      tridactyl = {
        name = "Tridactyl";
        genericName = "Firefox Vim Config";
        exec = "firefox-nightly -P tridactyl %U";
        terminal = false;
        categories = [
          "Application"
          "Network"
          "WebBrowser"
        ];
        mimeType = [
          "text/html"
          "text/xml"
        ];
      };

    };

    programs.firefox = {

      package = inputs.firefox-nightly.packages.${pkgs.system}.firefox-nightly-bin;

      enable = true;

      nativeMessagingHosts = with pkgs; [ tridactyl-native ];

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
        };
      };

      profiles.tridactyl = {

        id = 1;

        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          bitwarden
          fastforwardteam
          youtube-recommended-videos
          translate-web-pages
          darkreader
          decentraleyes
          tridactyl
        ];

        settings = {
          # Remove exit buttons in titlebar
          "browser.tabs.inTitlebar" = 0;

          # Middle click scroll
          "general.autoScroll" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

          # Disable FF sync and Pocket
          "extensions.pocket.enabled" = false;
          "identity.fxaccounts.enabled" = true;

          # Remove restrictions
          "xpinstall.signatures.required" = false;

          "browser.startup.homepage" = "http://localhost:8080";
        };
      };

    };
  };
}
