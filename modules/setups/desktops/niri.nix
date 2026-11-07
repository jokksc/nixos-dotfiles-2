{ lib, config, pkgs, inputs, ...}:

{
  imports = [
    inputs.niri.nixosModules.niri
    inputs.noctalia.nixosModules.default
    inputs.stylix.nixosModules.stylix
  ];
  
  # Niri
  # ---
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

  # services.greetd = {
  #   enable = true;
  #   settings.default_session = {
  #     command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
  #     user = "greeter";
  #   };
  # };

  # Noctalia System things
  # ---
  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;
    # Use upstream's prebuilt package straight from noctalia.cachix.org instead
    # of rebuilding the (large, ~hour) C++ tree against our nixpkgs.
    package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  # Stylix
  # ---
  stylix = {
    enable = true;
    polarity = "dark";

    # Kanagawa, vendored in-repo so the build never depends on whatever version
    # of `base16-schemes` happens to be pinned. To use an upstream scheme
    # instead: stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
    base16Scheme = ../../../dotfiles/stylix/ashes.yaml;

    # "Static mind, like the sea" (静心如海) — a meditating pepe before Hokusai's
    # Great Wave off Kanagawa, vendored in-repo (pngquant-optimized).
    # image = ../../themes/wallpaper.png;

    # A hint of terminal transparency for that layered desktop look.
    opacity.terminal = 0.95;

    # cursor = {
    #   package = pkgs.bibata-cursors;
    #   name = "Bibata-Modern-Classic";
    #   size = 24;
    # };

    fonts = {
      monospace = { name = "Maple Mono NF"; };
      sansSerif = { name = "Maple Mono NF"; };
      serif     = { name = "Maple Mono NF"; };
      emoji     = { name = "Maple Mono NF"; };
      # sansSerif = { name = "Noto Sans"; };
      # serif     = { name = "Noto Serif"; };
      # emoji     = { name = "Noto Color Emoji"; };

      # sizes = {
      #   terminal     = 12;
      #   applications = 11;
      #   desktop      = 11;
      #   popups       = 11;
      # };
    };
  };

  home-manager.sharedModules = [(
    { config, lib, pkgs, ... }:
    {
      imports = [
        ../../home/niri.nix
        ../../home/noctalia.nix
        ../../home/stylix.nix # obsidian theming is disabled
      ];
    }
  )];
}