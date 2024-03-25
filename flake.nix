{
  description = "JakeDevs NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    nur.url = "github:nix-community/NUR";

    firefox.url = "github:nix-community/flake-firefox-nightly";

    blender-bin.url = "github:edolstra/nix-warez?dir=blender";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    ags.url = "github:Aylur/ags";
		
		schizofox.url = "github:schizofox/schizofox";

    nixvim.url = "github:jakedevs/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nur, chaotic, blender-bin, home-manager, hyprland, firefox, nixvim, ... }@inputs:
    let
      system = "x86_64-linux";
    in
    {

      nixosConfigurations = {

        main = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./machines/main/configuration.nix
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

        server = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
        };
      };

    };
}

