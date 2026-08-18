{ lib, config, pkgs, myOptions ...}:
let
  primaryUser = myOptions.users.primaryUser
in
{
  services.tailscale = {
    enable = true;
    extraSetFlags = [
      "--operator=${primaryUser}"  
    ];
  };
}
