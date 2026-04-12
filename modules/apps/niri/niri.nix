{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./config/binds.nix
    ./config/outputs.nix
    ./config/input.nix
    ./config/layout.nix
    ./config/rules.nix
  ];

  home.packages = with pkgs; [
    xwayland-satellite
  ];
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;

    settings = {
      environment = {
        "NIXOS_OZONE_WL" = "1";
        "EDITOR" = "hx";
      };

      # Seems like we no longer need to manually configure xwayland here.

      screenshot-path = "~/Pictures/Captures-Niri/%Y-%m-%d %H-%M-%S.png";

      hotkey-overlay = {
        skip-at-startup = true;
      };

      spawn-at-startup = [
        {
          command = [
            "noctalia-shell"
          ];
        }
      ];
    };

    debug = {
      # Allows notification actions and window activation from Noctalia.
      honor-xdg-activation-with-invalid-serial = [];
    };
  };
}
