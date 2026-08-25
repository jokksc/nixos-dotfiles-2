{ lib, config, pkgs, ...}:
{
  boot.loader.systemd-boot.configurationLimit = 10;
  # This assumes you're using systemd-boot instead of grub

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}
