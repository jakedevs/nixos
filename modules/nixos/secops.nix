{
  config,
  pkgs,
  inputs,
  username,
  ...
}:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    secrets.main = {
      mode = "0700";
      owner = config.users.users.${username}.name;
      group = config.users.users.${username}.group;
      path = "/home/jake/.ssh/id_ed25519";
    };
  };

  environment.systemPackages = with pkgs; [
    sops
    age
  ];

  # Fixes https://github.com/Mic92/sops-nix/issues/391
  system.activationScripts = {
    sshperms = ''chown jake:users /home/${username}/.ssh'';
  };
}
