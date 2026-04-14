{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      thumbfast
      uosc
      autosubsync-mpv
    ];
    bindings = {
      r = "cycle_values video-rotate 90 180 270 0";
    };
  };
}
