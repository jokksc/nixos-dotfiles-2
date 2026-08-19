{ lib, config, pkgs, ...}:
  
{
  environment.systemPackages = with pkgs; [
    llama-cpp
  ];
  
  # services.llama-cpp.enable = true;
}