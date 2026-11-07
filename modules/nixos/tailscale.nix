{ lib, config, pkgs, primaryUser, ...}:
{
  services.tailscale = {
    enable = true;
    extraSetFlags = [
      "--operator=${primaryUser}"  
    ];
  };
}
