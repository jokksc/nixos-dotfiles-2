{config, lib, pkgs, primaryUser, ...}:
    
{
  hardware.i2c.enable = true;
  boot.kernelModules = [ "i2c-dev" ];
  users.users.${primaryUser}.extraGroups = [ "i2c" ];
}