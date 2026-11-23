{ lib, config, pkgs, ...}:
  
let
  # https://github.com/samuelngs/apple-emoji-ttf (not packaged in nixpkgs)
  apple-emoji-ttf = pkgs.stdenvNoCC.mkDerivation {
    pname = "apple-color-emoji";
    version = "macos-26-20260722";
    src = pkgs.fetchurl {
      url = "https://github.com/samuelngs/apple-emoji-ttf/releases/download/macos-26-20260722-484daf4e/AppleColorEmoji-Linux.ttf";
      hash = "sha256-43x69iZaxKCvbVe8ZehhCad22ZZug0MzRVf2PaSCUW8=";
    };
    dontUnpack = true;
    installPhase = ''
      runHook preInstall
      mkdir -p $out/share/fonts/truetype
      cp $src $out/share/fonts/truetype/AppleColorEmoji.ttf
      runHook postInstall
    '';
    meta.license = lib.licenses.unfree; # Apple emoji artwork
  };

in

{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    jetbrains-mono
    fira-code
    nerd-fonts.fira-code
    twemoji-color-font
    maple-mono.NF
    noto-fonts
    # noto-fonts-color-emoji
    apple-emoji-ttf
  ];

  # Prefer Apple Color Emoji over other emoji fonts (twemoji, noto, ...)
  fonts.fontconfig.localConf = /* xml */ ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
    <fontconfig>
      <alias binding="strong">
        <family>emoji</family>
        <prefer>
          <family>Apple Color Emoji</family>
        </prefer>
      </alias>
      <match target="pattern">
        <test qual="any" name="family"><string>Noto Color Emoji</string></test>
        <edit name="family" mode="assign" binding="strong"><string>Apple Color Emoji</string></edit>
      </match>
      <match target="pattern">
        <test qual="any" name="family"><string>Twemoji</string></test>
        <edit name="family" mode="assign" binding="strong"><string>Apple Color Emoji</string></edit>
      </match>
    </fontconfig>
  '';
}