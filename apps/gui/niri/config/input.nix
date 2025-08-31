{
  programs.niri.settings = {
    input = {
      mod-key = "Super";
      keyboard = {
        repeat-delay = 200;
        repeat-rate = 60;
        xkb = {
          layout = "us";
        };
      };
      mouse = {
        accel-speed = -0.5;
      };
      touchpad = {
        tap = true;
        dwt = true;
        natural-scroll = true;
        click-method = "clickfinger";
        scroll-factor = 0.34;
        accel-speed = 0;
      };
      focus-follows-mouse = {
        enable = true;
      };
    };
    cursor = {
      hide-after-inactive-ms = 5000;
    };
  };
}
