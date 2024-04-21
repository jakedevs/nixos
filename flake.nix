{
  description = "JakeDevs NixOS";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs.url = "github:numtide/nixpkgs-unfree/nixos-unstable";
    nixpkgs.inputs.nixpkgs.follows = "nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

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

    nixvim.url = "github:jakedevs/nixvim";
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
      firefox,
      nixvim,
      disko,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {

      nixosConfigurations = {

        jake = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
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

        buildIso = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          modules = [ ./machines/ISO/configuration.nix ];
        };
      };
    };

  nixConfig.extra-substituters = [
    "https://numtide.cachix.org"
    "https://hyprland.cachix.org"
		"https://cuda-maintainers.cachix.org"
  ];
  nixConfig.extra-trusted-public-keys = [
    "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
		"cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
  ];
}
