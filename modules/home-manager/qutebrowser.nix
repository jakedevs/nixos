{ inputs, ... }:
{
  programs.qutebrowser = {
    enable = true;
    extraConfig = "c.colors.webpage.preferred_color_schemes = dark";
  };
}
