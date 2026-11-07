{ config, pkgs, inputs, ...}:
let
#  secrets = import ./secrets.nix
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles-2/dotfiles";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    # alacritty = "alacritty";
#    nvim = "nvim";
  };
  # primaryUser = inputs.myOptions.users.primaryUser;
in    
{
  imports = [
    inputs.zen-browser.homeModules.beta
    inputs.sops-nix.homeModules.sops
    # inputs.stylix.homeModules.stylix
    # inputs.pi-nix.homeManagerModules.default
    # ../../modules/home/bash.nix
    ../../modules/home/zsh.nix
    # ../../modules/home/gnome.nix
    ../../modules/home/vscode.nix
    # ../../modules/home/stylix.nix
    # ../../modules/home/niri.nix
    # ../../modules/home/noctalia.nix
  ];
  
  home.username = "jokub";
  home.homeDirectory = "/home/jokub";
  home.stateVersion = "26.05";


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
    # skills = ../../dotfiles/skills
    web = {
      enable = true;
      extraArgs = [
        "--port" "4096"
        "--hostname" "0.0.0.0"
      ];
    };
  };

  sops.age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
  sops.defaultSopsFile = ../../secrets/brave-search.yaml;
  sops.secrets.brave_api_key = { };

  programs.opencode.settings.mcp."brave-search" = {
    type = "local";
    command = [ "npx" "-y" "@brave/brave-search-mcp" ];
    enabled = true;
    environment.BRAVE_API_KEY = "{file:${config.home.homeDirectory}/.config/sops-nix/secrets/brave_api_key}";
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
  

  
}
