{ lib, config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    vscode
    firefox
    # vscodium
    kdePackages.filelight
    # pinta
    # rnote
    ptyxis
    pika-backup
    mission-center
    resources
    blackbox-terminal
    python314
    ddcutil
    vicinae
    cbonsai
  ];

  home-manager.sharedModules = [
    ({ config, lib, pkgs, ... }:
    {
      home.packages = with pkgs; [
        # i should make an option to remove discord when loading this module
        vesktop
        spotify
        localsend
        wl-clipboard
      ];

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
    })
  ];
}