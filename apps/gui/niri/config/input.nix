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
