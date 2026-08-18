# Not sure how useful but i had those configs previously when i ran in a virtual machine

{ lib, config, pkgs, ...}:
  
{
  virtualisation.virtualbox.guest.enable = true;
  
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "vboxvideo" ];
}