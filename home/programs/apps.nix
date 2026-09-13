{ pkgs, ... }:
{
  programs.vscode.enable = true;
  home.packages = [ pkgs.brave-origin ];
}
