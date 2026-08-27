{ lib, config, pkgs, inputs, ...}:

{
  imports = [
    inputs.niri.nixosModules.niri
    inputs.noctalia.nixosModules.default
    stylix.nixosModules.stylix
    ../features/noctalia.nix
    ../features/stylix.nix
  ];

  programs.niri.enable = true;
  # Use niri-flake's own prebuilt package (built against its nixpkgs) so it
  # comes from niri.cachix.org instead of compiling from source. This is the
  # exact build the niri-flake settings schema targets.
  programs.niri.package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-stable;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
    ];
    config.niri = {
      default = [
        "gnome"
        "gtk"
      ];
      "org.freedesktop.impl.portal.ScreenCast" = ["gnome"];
    };
  };

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
      user = "greeter";
    };
  };
}