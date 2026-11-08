{ ... }:
{
  # Nothing is stored in dconf for appindicator yet, so every key is still at
  # its schema default. Add keys here as you change them in the prefs dialog
  # (see `dconf dump /org/gnome/shell/extensions/appindicator/`).
  dconf.settings."org/gnome/shell/extensions/appindicator" = { };
}
