{
  programs.hyprlock = {
    enable = true;
    settings = {
      auth = {
        pam = {
          enabled = true;
        };
        fingerprint = {
          enabled = true;
        };
      };

      background = {
        blur_passes = 1; # 0 disables blurring
        blur_size = 7;
        noise = 1.17e-2;
      };

      label = {
        text = "$TIME";
        font_size = 90;
        position = "0, 300";
        halign = "center";
        valign = "center";
      };

      input-field = {
        size = "200,50";
        outline_thickness = 2;
        dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.35; # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true;
        fade_on_empty = false;
        rounding = -1;
        placeholder_text = ''<i><span foreground="##cdd6f4">Input Password...</span></i>'';
        hide_input = false;
        position = "0, -100";
        halign = "center";
        valign = "center";
      };
    };
  };
}
