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
      touchpad = {
        tap = true;
        dwt = true;
        natural-scroll = true;
        click-method = "clickfinger";
        scroll-factor = 0.34;
        accel-speed = 0;
      };
      trackpoint = {
        accel-speed = -0.3;
      };
      focus-follows-mouse = {
        enable = false;
      };
    };
    cursor = {
      hide-after-inactive-ms = 5000;
    };
  };
}
