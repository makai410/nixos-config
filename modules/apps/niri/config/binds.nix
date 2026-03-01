{ config, ... }:
{
  programs.niri.settings = {
    binds = with config.lib.niri.actions; {
      "Mod+Shift+Slash".action = show-hotkey-overlay;
      "XF86AudioRaiseVolume".action.spawn = [
        "~/scripts/volume_pamixer.sh"
        "up"
      ];
      "XF86AudioLowerVolume".action.spawn = [
        "~/scripts/volume_pamixer.sh"
        "down"
      ];
      "XF86AudioMute".action.spawn = [
        "~/scripts/volume_pamixer.sh"
        "mute"
      ];
      "Shift+XF86AudioRaiseVolume".action.spawn = [
        "~/scripts/volume_pamixer.sh"
        "bigup"
      ];
      "Shift+XF86AudioLowerVolume".action.spawn = [
        "~/scripts/volume_pamixer.sh"
        "bigdown"
      ];
      "XF86MonBrightnessDown".action.spawn = [
        "brightnessctl"
        "s"
        "5%-"
      ];
      "XF86MonBrightnessUp".action.spawn = [
        "brightnessctl"
        "s"
        "+5%"
      ];
      "XF86Display".action.spawn = [
        "~/scripts/toggle_gammastep.sh"
      ];
      "XF86NotificationCenter".action = toggle-overview;
      "XF86PickupPhone".action = toggle-overview;
      "XF86HangupPhone".action = toggle-overview;
      "XF86Favorites".action = toggle-overview;

      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;
      "Mod+Shift+1".action.move-column-to-workspace = 1;
      "Mod+Shift+2".action.move-column-to-workspace = 2;
      "Mod+Shift+3".action.move-column-to-workspace = 3;
      "Mod+Shift+4".action.move-column-to-workspace = 4;
      "Mod+Shift+5".action.move-column-to-workspace = 5;
      "Mod+Shift+6".action.move-column-to-workspace = 6;
      "Mod+Shift+7".action.move-column-to-workspace = 7;
      "Mod+Shift+8".action.move-column-to-workspace = 8;
      "Mod+Shift+9".action.move-column-to-workspace = 9;
      "Mod+Shift+E".action = quit;
      "Mod+F".action = maximize-column;
      "Mod+Shift+F".action = fullscreen-window;
      "Mod+Q".action = close-window;
      "Mod+H".action = focus-column-left;
      "Mod+J".action = focus-window-or-workspace-down;
      "Mod+K".action = focus-window-or-workspace-up;
      "Mod+L".action = focus-column-right;
      "Mod+Left".action = focus-column-left;
      "Mod+Down".action = focus-window-or-workspace-down;
      "Mod+Up".action = focus-window-or-workspace-up;
      "Mod+Right".action = focus-column-right;
      "Mod+Ctrl+H".action = focus-monitor-left;
      "Mod+Ctrl+J".action = focus-monitor-down;
      "Mod+Ctrl+K".action = focus-monitor-up;
      "Mod+Ctrl+L".action = focus-monitor-right;
      "Mod+Ctrl+Left".action = focus-monitor-left;
      "Mod+Ctrl+Down".action = focus-monitor-down;
      "Mod+Ctrl+Up".action = focus-monitor-up;
      "Mod+Ctrl+Right".action = focus-monitor-right;
      "Mod+Shift+H".action = move-column-left;
      "Mod+Shift+J".action = move-window-down-or-to-workspace-down;
      "Mod+Shift+K".action = move-window-up-or-to-workspace-up;
      "Mod+Shift+L".action = move-column-right;
      "Mod+Shift+Left".action = move-column-left;
      "Mod+Shift+Down".action = move-window-down-or-to-workspace-down;
      "Mod+Shift+Up".action = move-window-up-or-to-workspace-up;
      "Mod+Shift+Right".action = move-column-right;
      "Mod+Ctrl+Shift+H".action = move-column-to-monitor-left;
      "Mod+Ctrl+Shift+J".action = move-column-to-monitor-down;
      "Mod+Ctrl+Shift+K".action = move-column-to-monitor-up;
      "Mod+Ctrl+Shift+L".action = move-column-to-monitor-right;
      "Mod+Ctrl+Shift+Left".action = move-column-to-monitor-left;
      "Mod+Ctrl+Shift+Down".action = move-column-to-monitor-down;
      "Mod+Ctrl+Shift+Up".action = move-column-to-monitor-up;
      "Mod+Ctrl+Shift+Right".action = move-column-to-monitor-right;
      "Mod+WheelScrollUp".action = focus-column-left;
      "Mod+WheelScrollDown".action = focus-column-right;
      "Mod+Shift+WheelScrollUp".action = focus-window-or-workspace-up;
      "Mod+Shift+WheelScrollDown".action = focus-window-or-workspace-down;
      "Mod+U".action = focus-workspace-down;
      "Mod+I".action = focus-workspace-up;
      "Mod+Shift+U".action = move-column-to-workspace-down;
      "Mod+Shift+I".action = move-column-to-workspace-up;
      "Mod+V".action = toggle-window-floating;
      "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;
      "Mod+W".action = toggle-column-tabbed-display;
      "Mod+C".action = center-column;
      "Mod+BracketLeft".action = consume-or-expel-window-left;
      "Mod+BracketRight".action = consume-or-expel-window-right;
      "Mod+Comma".action = consume-window-into-column;
      "Mod+Period".action = expel-window-from-column;
      "Mod+R".action = switch-preset-column-width;
      "Mod+Shift+R".action = switch-preset-window-height;
      "Mod+Ctrl+R".action = reset-window-height;
      "Mod+Shift+Ctrl+R".action = reset-window-height;
      "Mod+Minus".action.set-column-width = "-5%";
      "Mod+Equal".action.set-column-width = "+5%";
      "Mod+Shift+Minus".action.set-window-height = "-5%";
      "Mod+Shift+Equal".action.set-window-height = "+5%";
      "Mod+Shift+A".action.screenshot = { };
      "Mod+Shift+Ctrl+A".action.screenshot-screen = { };
      # "Mod+E".action.spawn = [
      #   "bash"
      #   "-c"
      #   "tofi-run | xargs niri msg action spawn --"
      # ];
      "Mod+Space".action.spawn = "anyrun";
      "Mod+Z".action.spawn = "zen";
      "Mod+D".action.spawn = "supersonic";
      "Mod+N".action.spawn = "keepassxc";
      "Mod+T".action.spawn = "vscode";
      "Mod+Shift+T".action.spawn = "gnome-system-monitor";
      "Mod+Shift+C".action.spawn = [
        "hyprlock"
      ];
      "Mod+Return".action.spawn = "kitty";
      "Mod+X".action.spawn = "kitty";
      "Mod+Shift+P".action.spawn = "poweroff";
      "Mod+Shift+O".action.spawn = "reboot";
      "Mod+Tab".action = toggle-overview;
    };
  };
}