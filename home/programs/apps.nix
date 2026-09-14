{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    argvSettings."password-store" = "gnome-libsecret";
  };
  home.packages = with pkgs; [
    brave-origin
    trezor-suite
    pavucontrol
    seahorse
    (code-cursor.override {
      commandLineArgs = "--password-store=gnome-libsecret";
    })
  ];
}
