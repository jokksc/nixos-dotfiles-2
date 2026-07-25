{
  description = "NixOS from Scratch";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    mkHost = { desktopModule, homeModule }: nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hardware-configuration.nix
        ./hosts/common.nix
        desktopModule
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            users.jokub = { imports = [ ./home/common.nix homeModule ]; };
          };
        }
      ];
    };
  in
  {
    nixosConfigurations = {
      jok-nixos-qtile = mkHost {
        desktopModule = ./hosts/qtile.nix;
        homeModule = ./home/qtile.nix;
      };
      jok-nixos-gnome = mkHost {
        desktopModule = ./hosts/gnome.nix;
        homeModule = ./home/gnome.nix;
      };
    };
  };
}