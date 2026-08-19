{ lib, config, pkgs, unstable, ...}:
  
{
  environment.systemPackages = with unstable; [
    llama-cpp
  ];
  
  # services.llama-cpp.enable = true;
}