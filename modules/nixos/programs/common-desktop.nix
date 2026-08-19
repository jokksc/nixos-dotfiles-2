{ lib, config, pkgs, ...}:
  
{
  programs.firefox.enable = true;
  
  environment.systemPackages = with pkgs; [
    vscode
    vscodium
    kdePackages.filelight
    pinta
    rnote
    ptyxis
    pika-backup
    mission-center
  ];
}