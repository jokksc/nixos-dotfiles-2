{ config, pkgs, inputs, primaryUser, ...}:
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
    inputs.sops-nix.homeModules.sops
    ../../modules/home/zsh.nix
    ../../modules/home/vscode.nix
  ];
  
  home.username = (toString primaryUser);
  home.homeDirectory = "/home/jokub";
  home.stateVersion = "26.05";


#  programs.git = {
#    enable = true;
#    userName = "jokksc"
#    userEmail = ""
#  };
# skipped for now, since idk how to store emails/secrets  without pushing to git repos 
 


  sops.age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
  sops.defaultSopsFile = ../../secrets/brave-search.yaml;
  sops.secrets.brave_api_key = { };

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
