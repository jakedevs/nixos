{
  config,
  pkgs,
  inputs,
  username,
  ...
}:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  services = {
    openssh.enable = true;
  };

  programs.ssh.startAgent = true;

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/${username}/.config/sops/age/keys.txt";

    secrets.main = {
      owner = config.users.users.${username}.name;
      group = config.users.users.${username}.group;
    };
  };

  environment.systemPackages = with pkgs; [ pass-wayland ];
}
