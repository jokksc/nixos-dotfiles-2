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
  ];
  
}