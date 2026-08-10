{
  description = "NixOS from Scratch";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
 #   iloader = {
 #     url = "github:nab138/iloader";
 #   };
    # nix-flatpak = {
    #   url = "https://github.com/gmodena/nix-flatpak";
    # };
    # i'll implement this later
  };
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    primaryUser = "jokub";
    mkHost = { desktopModule, homeModule, hardwareConfig, ... }: nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs primaryUser; };
      modules = [
        hardwareConfig
        ./modules/nixos/common.nix
        desktopModule
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            extraSpecialArgs = { inherit inputs; };
            users.jokub = { imports = [ ./home/common.nix homeModule ]; };
          };
        }
      ];
    };
  in
  {
    nixosConfigurations = {
    #   jok-nixos = mkHost {
    #     desktopModule = ./hosts/qtile.nix;
    #     homeModule = ./home/qtile.nix;
    #   };
      jok-nixos = mkHost {
        hardwareConfig = ./hosts/jok-nixos/hardware-configuration.nix;
        desktopModule = ./modules/nixos/desktops/gnome.nix;
        homeModule = ./home/gnome.nix;
      };
    };
  };
}
