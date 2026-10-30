{ lib, config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    vscode
  ];

  home-manager.sharedModules = [
    ({ config, lib, pkgs, ... }:
    {
      home.packages = with pkgs; [
        nodejs
        nixpkgs-fmt
        neovim
        httpie
        nixd
      ];
    })
  ];
}