{ lib, config, pkgs, ...}:
  
{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    jetbrains-mono
    fira-code
    nerd-fonts.fira-code
    twemoji-color-font
  ];
}