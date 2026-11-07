{pkgs, inputs, lib, ... }: 
{
  imports = [
    ../../nixos/flatpak.nix
  ];

  home-manager.sharedModules = [
    ({ config, lib, pkgs, ... }:
    let
      fromFlathub = appId: { inherit appId; origin = "flathub"; };
    in
    {
      imports = [
        ../../home/flatpak.nix
      ];

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
    })
  ];
}