{
  programs.alacritty = {
    enable = true;
    theme = "ashes_dark";
    settings = {
      window = {
        padding = {
          x = 15;
          y = 15;
        };
        opacity = 0.8;
        blur = false; # FIXME: Wait for niri to support it
        decorations = "None";
      };
      font.size = 12;
      colors = {
        transparent_background_colors = true;
      };
      scrolling.history = 10000;
      cursor.style.shape = "Underline";
      mouse.hide_when_typing = true;
    };
  };
}
