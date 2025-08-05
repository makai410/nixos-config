{
  programs.niri.settings = {
    outputs = {
      # niri msg outputs
      eDP-1 = {
        scale = 2.00;
      };
      "PNP(SAC) G72 MAX 0000000000000" = {
        scale = 1.25;
        mode = {
          height = 1440;
          width = 2560;
          refresh = 179.999;
        };
        # Normal horizontal orientation
        transform = {
          rotation = 0;
        };
        # leftmost monitor
        position = {
          x = 0;
          y = 0;
        };
        focus-at-startup = true;
      };

      # Vertical
      "PNP(SAC) G52 MAX 0000000000000" = {
        scale = 1.25;
        mode = {
          height = 1440;
          width = 2560;
          refresh = 179.999;
        };
        # counter-clockwise
        transform = {
          rotation = 270;
        };
        # at the right of the first monitor
        position = {
          x = 2052; # a few more pixels to lower sensitivity
          y = 0;
        };
      };
    };
  };
}