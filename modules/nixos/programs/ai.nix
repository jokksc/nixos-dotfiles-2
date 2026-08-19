{ lib, config, pkgs, unstable, ...}:
  
{
  environment.systemPackages = with pkgs; [
    (llama-cpp.override { cudaSupport = true; })
  ];
  
  # services.llama-cpp.enable = true;
}