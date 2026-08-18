{ config, lib, pkgs, ...}:
# im not using this yet    
{
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
    # ./../../modules/nixos/common.nix
    ./../../modules/nixos/desktops/gnome.nix
    # ./../../home/gnome.nix
    # ./../../home/common.nix
  ];
}