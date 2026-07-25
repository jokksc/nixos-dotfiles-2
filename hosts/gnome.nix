{ pkgs, ... }:
{
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # trim the bloat you don't want, e.g.:
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    epiphany
    gnome-photos
  ];

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnome-extension-manager
  ];
}