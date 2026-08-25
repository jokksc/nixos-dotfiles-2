{ lib, config, pkgs, inputs, ...}:
  
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
    inputs.helix.packages."${pkgs.stdenv.hostPlatform.system}".helix
  ];
}