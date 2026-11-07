# Unified shell aliases, one place for every shell.
#
# This is a home-manager module file: it's imported from hosts/*/home.nix
# and the module system calls it automatically (no manual import {} needed).
#
# home.shellAliases fans out to programs.{bash,zsh,fish,nushell}.shellAliases,
# each shell writing the aliases into its own rc file when enabled
# (programs.<shell>.enable). Plain strings only — for shell-specific syntax
# (or to exclude a shell) use programs.<shell>.shellAliases instead.
{
  home.shellAliases = {
    btw = "echo i use nixos btw";
    nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles-2#jok-nixos";
    nrs2 = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles-2#jokub-vm";
    syu = "sudo nix flake update --flake ~/nixos-dotfiles-2 && sudo nixos-rebuild switch --flake ~/nixos-dotfiles-2#jok-nixos";
  };
}
