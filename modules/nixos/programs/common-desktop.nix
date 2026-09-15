{ lib, config, pkgs, inputs, myOptions, ...}:
let
  primaryUser = myOptions.users.primaryUser;
in
{
  programs.firefox.enable = true;
  programs.localsend = {
    enable = true;
    openFirewall = true;
  };
  
  # ddcutil - brightness controls for monitors
  boot.kernelModules = [ "i2c-dev" ];
  hardware.i2c.enable = true; 
  users.users.${primaryUser} = {
    extraGroups = [ "i2c" "networkmanager" "video" "audio" "input" "libvirtd" "kvm" ];
  };
  
  services.xserver = {
    enable = true;
  };

  nix.settings.extra-substituters = [
    "https://niri.cachix.org"
    "https://noctalia.cachix.org"
  ];

  nix.settings.extra-trusted-public-keys = [
    "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
  ];
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  
  networking.networkmanager.enable = true;
  
  nixpkgs.config.allowUnfree = true;
  
  services.printing.enable = true;

  environment.systemPackages = with pkgs; [
    vscode
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
    # inputs.helix.packages."${pkgs.stdenv.hostPlatform.system}".helix
  ];
}