# Everything related to installed software, in one module:
# core CLI tools, desktop apps, development tools, gaming and flatpaks.
{
  lib,
  config,
  pkgs,
  inputs,
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
    t3code
    pi-coding-agent
    uxplay
    zsh
    ghostty
    uv
    distrobox
    podman # you also need to enable module - see above
  ];

  programs.firefox.enable = true;

  virtualisation.podman.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      # ovmf.enable = true;
      # ovmf.packages = [ pkgs.OVMFFull.fd ];
    };
  };
  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  boot.kernelModules = [ "kvm-intel" ];

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  home-manager.sharedModules = [
    (
      {
        config,
        lib,
        pkgs,
        inputs, 
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
          # My Modules
          ../../modules/home/prismlauncher.nix
          ../../modules/home/flatpak.nix

          # homeModules
          inputs.zen-browser.homeModules.beta
        ];

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

        programs.zen-browser = {
          enable = true;
          setAsDefaultBrowser = true;
        };

        programs.opencode = {
          enable = true;
          # skills = ../../dotfiles/skills
          web = {
            enable = true;
            extraArgs = [
              "--port" "4096"
              "--hostname" "0.0.0.0"
            ];
          };
          settings = {
            # mcp."brave-search" = {
            #   type = "local";
            #   command = [ "npx" "-y" "@brave/brave-search-mcp" ];
            #   enabled = true;
            #   environment.BRAVE_API_KEY = "{file:${config.home.homeDirectory}/.config/sops-nix/secrets/brave_api_key}";
            # };
          };
        };
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
      }
    )
  ];
}
