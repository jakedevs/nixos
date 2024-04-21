{ inputs, ... }:
{
  services.ollama = {
    enable = true;
    acceleration = "cuda";
    home = "/home/jake";
    models = "/home/jake/Documents/ollama/models";
  };
}
