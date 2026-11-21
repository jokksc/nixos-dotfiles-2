{ lib, config, pkgs, primaryUser, ...}:
  
{
  nix.settings = {
    substituters =  [
      "https://cache.flox.dev"
    ];
    trusted-public-keys = [
      "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
    ];
  };

  nixpkgs.config.cudaSupport = true;

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = primaryUser;
    hardwareAcceleration = {
      enable = true;
      type = "nvenc";
      device = "/dev/dri/renderD128";
    };
  };

  nixpkgs.overlays = [
    (final: prev: {
      jellyfin-web = prev.jellyfin-web.overrideAttrs (finalAttrs: previousAttrs: {
        installPhase = ''
          runHook preInstall
          sed -i "s#</head>#<script src=\"configurationpage?name=skip-intro-button.js\"></script></head>#" dist/index.html
          mkdir -p $out/share
          cp -a dist $out/share/jellyfin-web
          runHook postInstall
        '';
      });
    })
  ];
}