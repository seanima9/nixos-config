{ config, lib, pkgs, ... }:

let
  wallpaperDir = "${config.home.homeDirectory}/Pictures/wallpapers";

  pick-wallpaper = pkgs.writeShellScriptBin "pick-wallpaper" ''
    dir=${lib.escapeShellArg wallpaperDir}
    [ -d "$dir" ] || exit 0
    choice=$(find "$dir" -maxdepth 1 -type f \( \
      -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o \
      -iname '*.webp' -o -iname '*.jxl' \
    \) -printf '%f\n' | sort | rofi -dmenu -i -no-custom -p wallpaper) || exit 0
    [ -n "$choice" ] || exit 0
    hyprctl hyprpaper wallpaper ",$dir/$choice"
  '';
in
{
  home.packages = [ pick-wallpaper ];

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      wallpaper = [
        {
          monitor = "";
          path = wallpaperDir;
          timeout = 0;
        }
      ];
    };
  };

  systemd.user.services.hyprpaper = {
    Unit.StartLimitBurst = 3;
    Unit.StartLimitIntervalSec = 60;
    Service.Restart = lib.mkForce "on-failure";
  };
}
