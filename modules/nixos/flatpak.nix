{ lib, config, pkgs, inputs, ...}:
  
{
  services.flatpak.enable = true;
  
  environment.systemPackages = with pkgs; [
    bazaar
  ];


}