{
  inputs,
  config,
  lib,
  ...
}:
{

  options.librewolfConfig.enable = lib.mkEnableOption "enable firefox config";
  config = lib.mkIf config.librewolfConfig.enable {
    programs.librewolf = {
      enable = true;

      settings = {
        "webgl.disabled" = false;
        "privacy.resistFingerprinting" = false;
      };
    };
  };
}
