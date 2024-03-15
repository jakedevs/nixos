{ lib, inputs, pkgs, ... }: {
  programs.firefox = {

    enable = true;
    package = inputs.firefox.packages.${pkgs.system}.firefox-nightly-bin;

    profiles.default = {
      name = "main";

      extensions = with pkgs.nur.repos.rycee.firefox-addons; [ ublock-origin bitwarden fastforwardteam ];

      settings = {
        "browser.tabsinTitlebar" = "0";
        "identity.fxaccounts.enabled" = false;
      };
    };
  };
}
