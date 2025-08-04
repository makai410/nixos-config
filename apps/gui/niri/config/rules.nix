{
  programs.niri.settings = {
    window-rules = [
      # Global rules
      {
        geometry-corner-radius =
          let
            r = 12.0;
          in
          {
            top-left = r;
            top-right = r;
            bottom-left = r;
            bottom-right = r;
          };
        clip-to-geometry = true;
      }

      {
        matches = [
          {is-floating = true;}
        ];
        shadow.enable = true;
      }

      {
        matches = [
          {
            is-window-cast-target = true;
          }
        ];
        focus-ring = {
          active.color = "#DA70D6";
        };
        shadow = {
          color = "#da70d66b";
        };
        tab-indicator = {
          active.color = "#f38ba8";
          inactive.color = "#da70d66b";
        };
      }

      {
        matches = [{app-id = "org.telegram.desktop";}];
        block-out-from = "screencast";
      }

      {
        matches = [
          { app-id = "^(vesktop)$"; }
          { app-id = "zen"; }
        ];
        open-maximized = true;
      }

      {
        matches = [
          {
            app-id = "zen";
            title = "Picture-in-Picture";
          }
        ];
        open-floating = true;
        default-floating-position = {
          x = 32;
          y = 32;
          relative-to = "bottom-right";
        };
        default-column-width = {fixed = 480;};
        default-window-height = {fixed = 270;};
      }

      {
        matches = [{title = "Picture in picture";}];
        open-floating = true;
        default-floating-position = {
          x = 32;
          y = 32;
          relative-to = "bottom-right";
        };
      }

      {
        # Sound control
        matches = [
          { app-id = "^org\.pulseaudio\.pavucontrol$"; }
        ];
        default-column-width = {
          proportion = 0.50;
        };
        default-window-height = {
          fixed = 500;
        };
        open-floating = true;
        default-floating-position = {
          x = 0;
          y = 0;
          relative-to = "top-right";
        };
      }

    ];
  };
}