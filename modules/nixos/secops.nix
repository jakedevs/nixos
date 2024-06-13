{
  pkgs,
  inputs,
  config,
  username,
  ...
}:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];
  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/jake/.config/sops/age/keys.txt";

  sops.secrets.main = { };

  environment.systemPackages = with pkgs; [ pass-wayland ];
}
