{ lib, config, pkgs, ...}:
  
{
   programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos btw";
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles-2#jok-nixos";
      syu = "sudo nix flake update --flake ~/nixos-dotfiles-2 && sudo nixos-rebuild switch --flake ~/nixos-dotfiles-2#jok-nixos";
    };
    initExtra = ''
      export PATH="$HOME/.local/share/pi-node/current/bin:$PATH"
    '';
  };
}