{
  config,
  lib,
  pkgs,
  ...
}:

let
  lua = lib.generators.mkLuaInline;

  bind = key: dispatcher: {
    _args = [
      key
      (lua dispatcher)
    ];
  };

  exec = cmd: ''hl.dsp.exec_cmd("${cmd}")'';
  moveFocus = dir: ''hl.dsp.focus({ direction = "${dir}" })'';
  moveWindow = dir: ''hl.dsp.window.move({ direction = "${dir}" })'';

  gotoWorkspace = n: ''hl.dsp.focus({ workspace = "${toString n}" })'';
  moveToWorkspace = n: ''hl.dsp.window.move({ workspace = "${toString n}" })'';

  workspaceBinds = lib.flatten (
    map (n: [
      (bind "SUPER + ${toString n}" (gotoWorkspace n))
      (bind "SUPER + SHIFT + ${toString n}" (moveToWorkspace n))
    ]) (lib.range 1 9)
  );

  cycleFcitx = pkgs.writeShellScript "cycle-fcitx" ''
    current=$(fcitx5-remote -n 2>/dev/null || true)
    case "$current" in
      pinyin) fcitx5-remote -s mozc ;;
      mozc) fcitx5-remote -s keyboard-gb ;;
      *) fcitx5-remote -s pinyin ;;
    esac
  '';
in
{
  xdg.configFile."uwsm/env".source =
    "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    hyprcursor.enable = true;
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 28;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    systemd.enable = false;
    package = null;
    portalPackage = null;

    settings = {
      config = {
        input = {
          kb_layout = "gb";
        };
        general.col = {
          active_border = lua "colors.accent";
          inactive_border = lua "colors.overlay0";
        };
        misc = {
          disable_hyprland_logo = true;
          force_default_wallpaper = 0;
          background_color = lua "colors.crust";
        };
        xwayland.force_zero_scaling = true;
        decoration = {
          blur = {
            enabled = true;
            size = 8;
            passes = 2;
          };
        };
      };

      layer_rule = [
        {
          match = {
            namespace = "waybar";
          };
          blur = true;
          ignore_alpha = 0.3;
          blur_popups = true;
        }
      ];

      bind = [
        (bind "SUPER + H" (moveFocus "l"))
        (bind "SUPER + J" (moveFocus "d"))
        (bind "SUPER + K" (moveFocus "u"))
        (bind "SUPER + L" (moveFocus "r"))

        (bind "SUPER + semicolon" (exec "${cycleFcitx}"))

        (bind "SUPER + SHIFT + H" (moveWindow "l"))
        (bind "SUPER + SHIFT + J" (moveWindow "d"))
        (bind "SUPER + SHIFT + K" (moveWindow "u"))
        (bind "SUPER + SHIFT + L" (moveWindow "r"))

        (bind "SUPER + B" (exec "brave-origin"))
        (bind "SUPER + T" (exec "ghostty"))
        (bind "SUPER + W" (exec "pick-wallpaper"))
        (bind "SUPER + SPACE" (exec "rofi -show drun"))

        (bind "SUPER + SHIFT + Q" "hl.dsp.window.close()")
        (bind "SUPER + SHIFT + M" "hl.dsp.exit()")
      ]
      ++ workspaceBinds;
    };
  };
}
