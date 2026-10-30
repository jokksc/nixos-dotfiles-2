{ lib, config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    vscode
    firefox
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
    vicinae
    cbonsai
  ];
}