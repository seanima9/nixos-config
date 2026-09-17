{ pkgs, ... }:
let
  libsecretArgs = {
    commandLineArgs = "--password-store=gnome-libsecret";
  };
in
{
  home.packages = with pkgs; [
    (vscode.override libsecretArgs)
    (code-cursor.override libsecretArgs)
    brave-origin
    tor-browser
    trezor-suite
    pavucontrol
    seahorse
  ];
}
