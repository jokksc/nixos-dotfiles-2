{ lib, config, pkgs, ...}:
{
  imports = [
    ../../nixos/steam.nix
  ];

  home-manager.sharedModules = [
    ({ config, lib, pkgs, ... }:
    {
      imports = [
        ../../home/prismlauncher.nix
      ];
    })
  ];
}