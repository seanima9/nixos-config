{ pkgs, ... }:
{
  programs.vscode.enable = true;
  home.packages = with pkgs; [
    brave-origin
    trezor-suite
    pavucontrol
  ];
}
