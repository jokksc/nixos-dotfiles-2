{ config, pkgs, ... }:
{
  # GNOME-specific home-manager config goes here.
  # Uncomment/adjust as you figure out what you actually want.

   dconf.settings = {
  #   "org/gnome/desktop/interface" = {
  #     color-scheme = "prefer-dark";
  #     clock-format = "24h";
  #   };
     "org/gnome/desktop/wm/preferences" = {
       button-layout = "appmenu:minimize,maximize,close";
     };
     "org/gnome/shell" = {
       favorite-apps = [
         "org.gnome.Nautilus.desktop"
         "zen-beta.desktop"
       ];
     };
   };

  # gnome shell extensions managed via home-manager
  # (requires the gnomeExtensions packages + gnome-shell-extensions module)
   home.packages = with pkgs; [
     gnomeExtensions.dash-to-dock
  #   gnomeExtensions.appindicator
     gnomeExtensions.blur-my-shell
     
   ];
}
