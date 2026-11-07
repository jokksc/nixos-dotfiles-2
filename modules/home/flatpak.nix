{ config, lib, pkgs, inputs, ...}: 
{
  imports = [
    inputs.flatpaks.homeManagerModules.nix-flatpak
  ];

  services.flatpak.remotes = [
    {
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    }
    {
      name = "gnome-nightly";
      location = "https://nightly.gnome.org/gnome-nightly.flatpakrepo";
    }
  ];

  services.flatpak.update.onActivation = true;
  services.flatpak.update.auto = {
    enable = true;
    onCalendar = "daily";
  };
}