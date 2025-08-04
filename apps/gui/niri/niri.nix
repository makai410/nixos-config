{ pkgs, ...}:
{
  imports = [
    ./config/binds.nix
    ./config/outputs.nix
    ./config/input.nix
    ./config/layout.nix
    ./config/rules.nix
  ];

  home.packages = with pkgs; [
    xwayland-satellite
    swaybg
    libnotify
    pamixer
  ];
  home.file = {
    "scripts".source = pkgs.fetchFromGitHub {
      owner = "dbeley";
      repo = "scripts";
      rev = "a8607fbfb8c50543629e14ec483473459229091d";
      sha256 = "XBumWlu4+z/jTKLK71Lr0hMeLhc43XD3oEzY+YUMzN4=";
    };
  };
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;

    settings = {
      environment = {
        "NIXOS_OZONE_WL" = "1";
        "DISPLAY" = ":0";
        "EDITOR" = "nvim";
      };

      screenshot-path = "~/Pictures/Captures-Niri/%Y-%m-%d %H-%M-%S.png";

      spawn-at-startup = [
        {
          command = [
            "systemctl"
            "--user"
            "reset-failed"
            "waybar-service"
          ];
        }
        {
          command = [ "mako" ];
        }
        {
          command = [ "xwayland-satellite" ];
        }
        {
          command = [
            "swaybg"
            "-m"
            "fill"
            "-i"
            "${config.stylix.image}"
          ];
        }
      ];

      workspaces = {
        "1-chat" = {
          name = "chat";
        };
        "2-coding" = {
          name = "coding";
        };
      };

      hotkey-overlay = {
        skip-at-startup = true;
      };
    };
  };
}