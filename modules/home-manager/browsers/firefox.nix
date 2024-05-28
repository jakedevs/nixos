{
  lib,
  inputs,
  pkgs,
  config,
  ...
}:
{

  options.firefoxConfig.enable = lib.mkEnableOption "enable firefox config";

  config = lib.mkIf config.firefoxConfig.enable {

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
        ];

        settings = {
          # Remove exit buttons in titlebar
          "browser.tabs.inTitlebar" = 0;

          # Middle click scroll
          "general.autoScroll" = true;

          # Disable FF sync and Pocket
          "extensions.pocket.enabled" = false;
          "identity.fxaccounts.enabled" = true;

          # Graphix
          "gfx.webrender.all" = true;
          "media.ffmpeg.vaapi.enabled" = true;
          "widget.dmabuf.force-enabled" = true;

          # Minimal new tab
          "browser.newtabpage.activity-stream.feeds.system.topstories" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.feeds.system.topsites" = false;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;

          # Remove restrictions
          "xpinstall.signatures.required" = false;
        };
      };
    };
  };
}
