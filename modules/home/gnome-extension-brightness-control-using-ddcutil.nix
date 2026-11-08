{ pkgs, ... }:
{
  dconf.settings."org/gnome/shell/extensions/display-brightness-ddcutil" = {
    button-location = 0;
    # The extension's own default is a store path baked into its package; point
    # it at ddcutil explicitly so it tracks the system build instead of a stale
    # generation's /nix/store path.
    ddcutil-binary-path = "${pkgs.ddcutil}/bin/ddcutil";
    ddcutil-sleep-multiplier = 40.0;
    decrease-brightness-shortcut = [ "<Control>XF86MonBrightnessDown" ];
    increase-brightness-shortcut = [ "<Control>XF86MonBrightnessUp" ];
    position-system-menu = 3.0;
    show-value-label = true;
    step-change-keyboard = 2.0;
  };
}
