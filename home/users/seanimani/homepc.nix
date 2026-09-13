{ ... }:
{
  imports = [
    ../../programs/hyprland.nix
    ../../programs/fcitx5.nix
    ../../programs/hyprpaper.nix
    ../../programs/waybar.nix
    ../../programs/rofi.nix
    ../../programs/ghostty.nix
    ../../programs/apps.nix
    ../../programs/polkit.nix
  ];

  wayland.windowManager.hyprland.settings.monitor = [
    { output = "DP-3"; mode = "1920x1080@165"; position = "0x0"; scale = 1; }
    { output = "DP-1"; mode = "3840x2160@165"; position = "1920x0"; scale = 1.5; }
    { output = "HDMI-A-1"; mode = "1920x1080@60"; position = "4480x0"; scale = 1; }
  ];
}
