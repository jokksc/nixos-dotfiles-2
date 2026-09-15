{ lib, config, pkgs, inputs, myOptions, ...}:
  
{
  nix.settings.extra-substituters = [
    "https://niri.cachix.org"
    "https://noctalia.cachix.org"
  ];

  nix.settings.extra-trusted-public-keys = [
    "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
  ];

  networking.networkmanager.enable = true;
  
  nixpkgs.config.allowUnfree = true;
  
  services.printing.enable = true;

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
    oxker
  ];
  
}