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
    helix.url = "github:helix-editor/helix/master";
    # pi-nix = {
    #   url = "github:cyprx/pi.nix";
    #   # nixpkgs.follows = "nixpkgs";
    # };
    # BULLSHIT
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
  let
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
            users.jokub = { imports = [ ./modules/home/common.nix homeModule ]; };
          };
        }
      ];
    };
  in
  {
    nixosConfigurations = {
      jok-nixos = mkHost {
        hostname = "jok-nixos";
        homeModule = ./modules/home/gnome/default.nix;
        mainConfiguration = ./hosts/jok-nixos/default.nix;
      };
    };
  };
}