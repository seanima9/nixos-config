# Configuration is managed using VS Code Settings Sync not via Nix Home Manager,
# need to login on VS Code for configuration to be pulled down and used.

{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
  };
}
