{ lib, config, pkgs, unstable, ...}:
  
{
  environment.systemPackages = with unstable; [
    (llama-cpp.override { cudaSupport = true; })
  ];
  
  # services.llama-cpp.enable = true;
}