{ pkgs, ...}:
{
programs.vscode = {
    enable = true;
    profiles.default.userSettings = {
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";

      "chat.commandCenter.enabled" = false;
      "github.copilot.enable" = { "*" = false; };
      "workbench.commandPalette.experimental.suggestCommands" = false;

      "telemetry.telemetryLevel" = "off";
      "redhat.telemetry.enabled" = false;
    };
    profiles.default.extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      ms-vscode.remote-explorer
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-ssh-edit
    ];
  };
}