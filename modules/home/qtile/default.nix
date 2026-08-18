{ config, pkgs, ... }:
let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles-2/dotfiles";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in
{
  xdg.configFile."qtile" = {
    source = create_symlink "${dotfiles}/qtile";
    recursive = true;
  };
}