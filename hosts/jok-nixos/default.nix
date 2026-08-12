{ config, lib, pkgs, ...}:
    
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos/common.nix
    ./../../modules/nixos/desktops/gnome.nix
  ];
}