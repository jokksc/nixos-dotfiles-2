{ lib, config, pkgs, ...}:
  
{
  imports = [
    ../nixos/gnome.nix
  ];

  home-manager.sharedModules = [
    ({ config, lib, pkgs, ... }:
    {
      imports = [
        ../../home/gnome.nix
      ];
    })
  ];
}