{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    nur.url = "github:nix-community/NUR";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    blender-bin.url = "github:edolstra/nix-warez?dir=blender";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = { self, nixpkgs, nur, chaotic, blender-bin, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
    in
    {

      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [

          ./configuration.nix

          chaotic.nixosModules.default

          nur.nixosModules.nur

          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }

          ({ inputs, config, pkgs, ... }: {
            nixpkgs.overlays = [ blender-bin.overlays.default nur.overlay ];
            environment.systemPackages = [ pkgs.blender_4_0 ];
          })
        ];
      };

    };
}

