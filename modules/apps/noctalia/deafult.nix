{
  # Wallpaper
  home.file.".cache/noctalia/wallpapers.json" = {
    text = builtins.toJSON {
      defaultWallpaper = toString ../../../assets/wallpapers/acane_washmachine.jpg;
    };
  };
  # Calendar
  services.gnome.evolution-data-server.enable = true;
}
