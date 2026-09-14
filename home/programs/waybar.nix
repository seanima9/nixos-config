{ pkgs, ... }:

let
  # Waybar 0.15 sends `dispatch workspace N`; Hyprland Lua rejects that as
  # `hl.dispatch(workspace N)`. Super+N already uses hl.dsp.focus. Drop when 0.16.
  waybar = pkgs.waybar.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      substituteInPlace src/modules/hyprland/workspace.cpp \
        --replace-fail \
          'm_ipc.getSocket1Reply("dispatch workspace " + std::to_string(id()));' \
          'm_ipc.getSocket1Reply("dispatch hl.dsp.focus({ workspace = \"" + std::to_string(id()) + "\" })");' \
        --replace-fail \
          'm_ipc.getSocket1Reply("dispatch workspace name:" + name());' \
          'm_ipc.getSocket1Reply("dispatch hl.dsp.focus({ workspace = \"" + name() + "\" })");'
    '';
  });

  nordvpn-status = pkgs.writeShellScript "nordvpn-status" ''
    status=$(nordvpn status 2>/dev/null || true)
    case "$status" in
      *"Status: Connected"*)
        country=$(printf '%s\n' "$status" | awk -F': ' '/^Country:/{print $2; exit}')
        printf '{"text":"VPN %s","class":"connected"}\n' "''${country:-on}"
        ;;
      *)
        printf '{"text":"VPN off","class":"disconnected"}\n'
        ;;
    esac
  '';
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    package = waybar;

    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 32;
      spacing = 8;
      fixed-center = false;
      output = [ "DP-1" ];

      modules-left = [ "clock" "custom/nordvpn" "pulseaudio/slider" "mpris" ];
      modules-center = [ "hyprland/workspaces" ];
      modules-right = [
        "network"
        "bluetooth"
        "systemd-failed-units"
        "cpu"
        "memory"
        "temperature"
      ];

      clock.format = "{:%a %b %d  %H:%M}";

      "hyprland/workspaces" = {
        format = "{id}";
        all-outputs = true;
        on-click = "activate";
      };

      "custom/nordvpn" = {
        exec = "${nordvpn-status}";
        return-type = "json";
        interval = 10;
        on-click = "nordvpn-gui";
      };

      mpris = {
        format = "{player}: {title}";
        format-paused = "{player}: {title} (paused)";
        max-length = 48;
      };

      network = {
        format-wifi = "NET {essid}";
        format-ethernet = "NET wired";
        format-disconnected = "NET off";
        tooltip-format-ethernet = "{ifname}";
      };

      bluetooth = {
        format = "BT {status}";
        format-connected = "BT {device_alias}";
        format-off = "BT off";
        on-click = "blueman-manager";
      };

      "pulseaudio/slider" = {
        min = 0;
        max = 100;
        orientation = "horizontal";
      };

      "systemd-failed-units" = {
        hide-on-ok = true;
        format = "systemd {nr_failed} failed";
        system = true;
        user = true;
      };

      cpu = {
        format = "CPU {usage}%";
        interval = 2;
        states = {
          warning = 70;
          critical = 90;
        };
      };

      memory = {
        format = "RAM {percentage}%";
        interval = 2;
        states = {
          warning = 70;
          critical = 90;
        };
      };

      temperature = {
        format = "TEMP {temperatureC}°C";
        interval = 2;
        states = {
          warning = 70;
          critical = 85;
        };
      };
    };

    style = ''
      * {
        font-family: sans-serif;
        font-size: 13px;
        min-height: 0;
        border: none;
      }

      window#waybar {
        background: alpha(@base, 0.8);
        color: @text;
      }

      tooltip {
        background: @mantle;
        color: @text;
        border: 1px solid @surface1;
      }

      .modules-left,
      .modules-right {
        padding: 0 8px;
      }

      #workspaces button {
        color: @overlay0;
        padding: 0 6px;
        background: transparent;
      }

      #workspaces button.active {
        color: @accent;
      }

      #workspaces button:hover {
        color: @text;
        background: @surface0;
      }

      #workspaces button.urgent {
        color: @red;
      }

      label.module {
        padding: 0 10px;
        margin: 0 2px;
      }

      #custom-nordvpn.connected,
      #bluetooth.connected {
        color: @green;
      }

      #bluetooth.on {
        color: @blue;
      }

      #mpris.playing {
        color: @green;
      }

      #custom-nordvpn.disconnected,
      #network.disconnected,
      #bluetooth.off,
      #mpris.paused {
        color: @overlay0;
      }

      #cpu.warning,
      #memory.warning,
      #temperature.warning {
        color: @peach;
      }

      #cpu.critical,
      #memory.critical,
      #temperature.critical {
        color: @red;
      }

      #systemd-failed-units {
        color: @red;
      }

      #pulseaudio-slider slider {
        min-height: 0;
        min-width: 0;
        opacity: 0;
        background-image: none;
        border: none;
        box-shadow: none;
      }

      #pulseaudio-slider trough {
        min-height: 8px;
        min-width: 80px;
        border-radius: 4px;
        background: @surface0;
      }

      #pulseaudio-slider highlight {
        min-width: 8px;
        border-radius: 4px;
        background: @accent;
      }
    '';
  };
}
