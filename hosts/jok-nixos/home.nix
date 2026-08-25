{ config, pkgs, inputs, ...}:
let
#  secrets = import ./secrets.nix
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles-2/dotfiles";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    alacritty = "alacritty";
#    nvim = "nvim";
  };
in    
{
  imports = [
    inputs.zen-browser.homeModules.beta
    inputs.flatpaks.homeManagerModules.nix-flatpak
    # inputs.pi-nix.homeManagerModules.default
    ../../modules/home/bash.nix
    ../../modules/home/gnome/default.nix
  ];
  
  home.username = "jokub";
  home.homeDirectory = "/home/jokub";
  home.stateVersion = "26.05";

  services.flatpak.remotes = [
    {
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    }
  ];

  services.flatpak.packages = [
    { appId = "com.brave.Browser"; origin = "flathub";}
    "com.obsproject.Studio"
    "com.github.PintaProject.Pinta"
    "com.github.flxzt.rnote"
    "net.ankiweb.Anki"
    "ca.desrt.dconf-editor"
    "com.github.finefindus.eyedropper"
    "com.ranfdev.Geopard"
    "org.localsend.localsend_app"
    "io.gitlab.news_flash.NewsFlash"
    "org.vinegarhq.Sober"
    "com.stremio.Stremio"
    "org.telegram.desktop"
    "io.github.tanaybhomia.Whisp"
    "page.codeberg.M23Snezhok.Vinyl"
  ];

  services.flatpak.update.onActivation = true;
  services.flatpak.update.auto = {
    enable = true;
    onCalendar = "daily";
  };

#  programs.git = {
#    enable = true;
#    userName = "jokksc"
#    userEmail = ""
#  };
# skipped for now, since idk how to store emails/secrets  without pushing to git repos 
  # programs.pi-coding-agent = {
  #   enable = true;
  #   # extensions = [ "all" ];
  #   # disabledExtensions = [ "rtk" ];
  #   # https://github.com/cyprx/pi.nix
  # };
  # BULLSHITTTT
 
  # home.sessionVariables = {
  #   PI_EXTENSIONS = "all";
  #   PI_DISABLE_EXTENSIONS = "rtk"; 
  # };

  programs.opencode = {
    enable = true;  
  };
  
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
  };
#    initExtra = ''
#      export PS1='\[\e[48;5;33m\]\u\[\e[0m\] \[\e[48;5;33m\]in \w\[\e[0m\] \\$ '
#    '';
  
#  programs.alacritty={
#    enable = true;
#    settings = {
#      window.opacity = 0.9;
#      font.normal = {
#        family = "JetBrains Mono";
#        style = "Regular";
#      };
#      font.size = 12;
#    };
#    
#  };
  
#  home.file.".config/qtile".source = ./home-manager-dotfiles/qtile;
  home.file.".config/bat/config".text = ''
    --theme="Nord"
    --style="numbers,changes,grid"
    --paging=auto
  '';
  
#  xdg.configFile."qtile" = { # this symlinks config existing in home-manager-dotfiles to current nix build, making it easier to change and get live updates, without needing to rebuild nixos
#    source = config.lib.file.mkOutOfStoreSymlink "/home/jokub/nixos-dotfiles-2/home-manager-dotfiles/qtile/";
#    recursive = true;
#  };

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

#  xdg.configFile."qtile" = {
#    source = create_symlink "${dotfiles}/qtile/";
#    recursive = true;
#  };
  
  

  home.packages = with pkgs; [
    bat
    atool
    httpie
    neovim
    # nil #lsp for nix language
    nixd # switched to this
    nixpkgs-fmt
    ripgrep # used for telescope to work?
    # nodejs
    # gss # for compilation
    obsidian
    localsend
    vesktop
    prismlauncher
    spotify
    # pinta
    # rnote
    # ptyxis
  ];
}
