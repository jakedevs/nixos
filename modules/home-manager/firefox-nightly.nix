{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
{

  options.firefoxNightlyConfig.enable = lib.mkEnableOption "enable firefox config";

  config = lib.mkIf config.firefoxNightlyConfig.enable {

    programs.firefox = {

      package = inputs.firefox-nightly.packages.${pkgs.system}.firefox-nightly-bin;

      enable = true;

      nativeMessagingHosts = with pkgs; [ tridactyl-native ];

      profiles.nightly = {

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
        };

        userChrome = ''
          #main-window[tabsintitlebar="true"]:not([extradragspace="true"]) #TabsToolbar > .toolbar-items {
            opacity: 0;
            pointer-events: none;
          }
          #main-window:not([tabsintitlebar="true"]) #TabsToolbar {
              visibility: collapse !important;
          }
          #sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] #sidebar-header {
            display: none;
          }
          .tab {
            margin-left: 1px;
            margin-right: 1px;
           }

          #nav-bar, #urlbar-container, #searchbar { visibility: collapse !important; }
        '';
      };
    };
  };
}
