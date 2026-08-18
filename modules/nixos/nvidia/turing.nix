# Make sure your NVIDIA GPU supports open source drivers

{ config, lib, pkgs, ... }:
  
{
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };
  
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    powerManagement = {
      enable = true;
      finegrained = false; #claude said to set this to true if its a hybrid laptop gpu
    };
  };
}