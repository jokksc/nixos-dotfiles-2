{
  description = "NixOS from Scratch";
  inputs = {
    # nixpkgs.url = "nixpkgs/nixos-26.05";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    flatpaks.url = "github:gmodena/nix-flatpak/?ref=latest";
    # i got these flakes from https://github.com/floatdrop/nnn-starter/blob/main/flake.nix
    # also dont pin noctalia to nixpkgs, cuz otherwise it would miss cache
    niri.url = "github:sodiboo/niri-flake";
    noctalia.url = "github:noctalia-dev/noctalia-shell/cachix";
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { 
    self, 
    nixpkgs, 
    nixpkgs-unstable, 
    home-manager, 
    flatpaks, 
    niri, 
    noctalia, 
    stylix, 
    ... 
  }@inputs: let
    myOptions.users.primaryUser = "jokub";

    mkHost = { homeModule, mainConfiguration, hostname, ... }:
    let
      system = "x86_64-linux";
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs myOptions hostname unstable; };
      modules = [
        mainConfiguration
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            extraSpecialArgs = { inherit inputs; };
            users.jokub = { imports = [ homeModule ]; };
          };
        }
      ];
    };
  in
  {
    nixosConfigurations = {
      jok-nixos = mkHost {
        hostname = "jok-nixos";
        homeModule = ./hosts/jok-nixos/home.nix;
        mainConfiguration = ./hosts/jok-nixos/default.nix;
      };
    };
  };
}