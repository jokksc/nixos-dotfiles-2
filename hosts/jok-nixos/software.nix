# Everything related to installed software, in one module:
# core CLI tools, desktop apps, development tools, gaming and flatpaks.
{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    # Gaming
    ../../modules/nixos/steam.nix

    # Flatpak support
    ../../modules/nixos/flatpak.nix
  ];

  environment.systemPackages = with pkgs; [
    # Core
    vim
    wget
    neovim
    git
    btop
    alacritty
    fresh-editor
    pfetch
    openssl
    nix-output-monitor
    # oxker

    # Desktop
    vscode
    firefox
    # vscodium
    kdePackages.filelight
    # pinta
    # rnote
    ptyxis
    blackbox-terminal
    pika-backup
    mission-center
    resources
    python314
    ddcutil
    vicinae
    cbonsai
  ];

  home-manager.sharedModules = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }:
      let
        fromFlathub = appId: {
          inherit appId;
          origin = "flathub";
        };
      in
      {
        imports = [
          # Gaming
          ../../modules/home/prismlauncher.nix

          # Flatpak
          ../../modules/home/flatpak.nix
        ];

        # NOTE: i should make an option to remove discord when loading this module
        home.packages = with pkgs; [
          vesktop
          spotify
          localsend
          wl-clipboard

          bat
          atool
          ripgrep # used for telescope to work?
          oxker

          nodejs
          nixpkgs-fmt
          httpie
          nixd
        ];

        programs.fzf.enable = true;

        programs.obsidian = {
          enable = true;
          package = pkgs.obsidian;
          # vaults."Documents/Obsidian Vaults/stylix" = {
          #   enable = true;
          #   settings.appearance = {
          #     "baseFontSize" = 16;
          #     "showRibbon" = false;
          #     # "enabledCssSnippets" = [
          #     #   "Banner"
          #     #   "Vault Tweaks"
          #     #   "style-settings"
          #     # ];
          #     "nativeMenus" = false;
          #     "cssTheme" = "Minimal";
          #     "slidingSidebar" = true;
          #     "floatingNavigation" = true;
          #   };
          # };
        };

        services.flatpak.packages = (map fromFlathub [
          "com.obsproject.Studio"
          "com.github.PintaProject.Pinta"
          "com.github.flxzt.rnote"
          "net.ankiweb.Anki"
          "ca.desrt.dconf-editor"
          "com.github.finefindus.eyedropper"
          "com.ranfdev.Geopard"
          # "org.localsend.localsend_app"
          "io.gitlab.news_flash.NewsFlash"
          "org.vinegarhq.Sober"
          "com.stremio.Stremio"
          "org.telegram.desktop"
          "io.github.tanaybhomia.Whisp"
          "page.codeberg.M23Snezhok.Vinyl"
          "de.swsnr.turnon"
        ]) ++ [
          # { appId = "org.gnome.Boxes.Devel"; origin = "gnome-nightly";}
        ];
      }
    )
  ];
}
