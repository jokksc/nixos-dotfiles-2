{ lib, pkgs, config, ...}:
{
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
}