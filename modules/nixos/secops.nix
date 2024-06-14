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
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    secrets.main = {
      owner = config.users.users.${username}.name;
      group = config.users.users.${username}.group;
      path = "/home/jake/.ssh/id_ed25519";
    };
  };

  environment.systemPackages = with pkgs; [ pass-wayland ];
}
