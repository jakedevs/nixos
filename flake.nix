{
  description = "JakeDevs NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";

    blender-bin.url = "github:edolstra/nix-warez?dir=blender";

    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1&ref=explicit-sync";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    helix.url = "github:helix-editor/helix";

  };

  outputs =
    {
      self,
      nixpkgs,
      nur,
      chaotic,
      blender-bin,
      home-manager,
      hyprland,
      disko,
      helix,
      ...
    }@inputs:
    {

      nixosConfigurations = {

        jake =
          let
            username = "jake";
          in
          nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs;
              username = username;
            };
            modules = [
              ./machines/main/configuration.nix
              chaotic.nixosModules.default
              nur.nixosModules.nur
              disko.nixosModules.disko
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = {
                  inherit inputs;
                  username = username;
                };
              }
              (
                {
                  inputs,
                  config,
                  pkgs,
                  ...
                }:
                {
                  nixpkgs.overlays = [
                    blender-bin.overlays.default
                    nur.overlay
                  ];
                  environment.systemPackages = [ pkgs.blender_4_0 ];
                }
              )
            ];
          };

        iberu =
          let
            username = "iberu";
          in
          nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs;
              username = username;
            };
            modules = [
              ./machines/iberu/configuration.nix
              chaotic.nixosModules.default
              nur.nixosModules.nur
              disko.nixosModules.disko
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = {
                  inherit inputs;
                  username = username;
                };
              }
              (
                {
                  inputs,
                  config,
                  pkgs,
                  ...
                }:
                {
                  nixpkgs.overlays = [ nur.overlay ];
                }
              )
            ];
          };

        buildIso = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          modules = [ ./machines/ISO/configuration.nix ];
        };
      };
    };

  nixConfig.extra-substituters = [
    "https://hyprland.cachix.org"
    "https://cuda-maintainers.cachix.org"
    "https://cache.garnix.io"
  ];
  nixConfig.extra-trusted-public-keys = [
    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
  ];
}
