{
  programs.niri.settings = {
    layout-rules = [
      {
        matches = [
          {namespace = "^noctalia-overview";}
        ];
        place-within-backdrop = true;
      }

      # FIXME: Wait for niri to support blur
      # {
      #   matches = [
      #     { namespace = "^noctalia-(background|launcher-overlay|dock)-.*$"; }
      #   ];
      #   background-effect = {
      #     xray = false;
      #   };
      # }
    ];
    window-rules = [
      # Global rules
      {
        geometry-corner-radius = let
          r = 20.0;
        in {
          top-left = r;
          top-right = r;
          bottom-left = r;
          bottom-right = r;
        };
        clip-to-geometry = true;
      }

      # FIXME: Wait for niri to support blur
      # {
      #   background-effect = {
      #     blur = true;
      #     xray = false;
      #   };
      # }

      {
        matches = [
          {is-floating = true;}
        ];
        shadow.enable = true;
      }

      {
        matches = [
          {
            app-id = "firefox";
            title = "Picture-in-Picture";
          }

          {
            app-id = "steam";
            title = "Friends List";
          }

          {
            app-id = "steam";
            title = "Steam Settings";
          }
        ];
        open-floating = true;
      }

      {
        matches = [
          {is-window-cast-target = true;}
        ];
        focus-ring = {
          active.color = "#f38ba8";
          inactive.color = "#7d0d2d";
        };
        border = {
          inactive.color = "#7d0d2d";
        };
        shadow = {
          color = "#7d0d2d70";
        };
        tab-indicator = {
          active.color = "#f38ba8";
          inactive.color = "#7d0d2d";
        };
      }

      {
        matches = [{app-id = "org.telegram.desktop";}];
        block-out-from = "screencast";
      }

      {
        matches = [
          {app-id = "^(vesktop)$";}
        ];
        open-maximized = true;
      }
    ];
  };
}
