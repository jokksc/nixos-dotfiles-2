{ lib, config, pkgs, ...}:
  
{
  programs.firefox.enable = true;
  programs.steam.enable = true;
  
  environment.systemPackages = with pkgs; [
    vim 
    wget 
    fresh-editor 
    alacritty 
    neovim 
    btop 
    # gedit
    # xwallpaper 
    vscode 
    pcmanfm 
    # rofi 
    git 
    pfetch
    distrobox
    podman
    bazaar
    vscodium
    kdePackages.filelight
    pinta
    rnote
    ptyxis
    ddcutil
    pika-backup
  ];
  
  virtualisation.podman.enable = true; # for distrobox
}