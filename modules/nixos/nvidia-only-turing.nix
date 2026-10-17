# Make sure your NVIDIA GPU supports open source drivers

{ config, lib, pkgs, ... }:
  
{
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };

  # Niri (and Wayland compositors in general) need NVIDIA DRM modeset
  # and fbdev enabled on the kernel command line.
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"
  ];

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