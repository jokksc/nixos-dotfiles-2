{ config, lib, pkgs, myOptions, ...}:
let
  primaryUser = myOptions.users.primaryUser;
in
{
  # ddcutil - brightness controls for monitors
  boot.kernelModules = [ "i2c-dev" ];
  hardware.i2c.enable = true; 
  users.users.${primaryUser} = {
    extraGroups = [ "i2c" ];
  };
  
  services.xserver = {
    enable = true;
  };
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  
  networking.networkmanager.enable = true;
  
  nixpkgs.config.allowUnfree = true;
  
  services.printing.enable = true;
}