{ lib, config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    vim
    wget 
    fresh-editor 
    alacritty 
    neovim 
    btop  
    git 
    pfetch
    openssl
    # oxker
    nix-output-monitor
  ];

  home-manager.sharedModules = [
    ({ config, lib, pkgs, ... }:
    {
      home.packages = with pkgs; [
        # i should make an option to remove discord when loading this module
            bat
            atool
            ripgrep # used for telescope to work?
            oxker
      ];

      programs.fzf.enable = true;
    })
  ];
}