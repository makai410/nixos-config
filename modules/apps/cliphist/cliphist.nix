{
  services.cliphist = {
    enable = true;

    # A Wayland session
    systemdTargets = ["config.wayland.systemd.target"];

    # Sway Target
    # if using make sure that:
    # "wayland.windowManager.sway.systemd.enable = true;" is set
    #systemdTargets = ["sway-session.target"];

    extraOptions = [
      "-max-dedupe-search"
      "10"
      "-max-items"
      "500"
    ];
    allowImages = true;
  };
}
