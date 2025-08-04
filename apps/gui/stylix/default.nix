{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.my.stylix;
  wallpaperCatalog = import ./wallpapers.nix { inherit pkgs; };
  wallpaperNames = builtins.attrNames wallpaperCatalog.wallpapers;
in
{
  options.my.stylix = {
    wallpaper = lib.mkOption {
      type = lib.types.enum wallpaperNames;
      default = wallpaperCatalog.defaultWallpaper;
      description = "Name of the wallpaper to use";
      example = "purple-waves";
    };
  };
  config.stylix = {
    enable = true;
    inherit (wallpaperCatalog.wallpapers.${cfg.wallpaper})
      image
      imageScalingMode
      ;

    polarity = "dark";
    fonts = {
      serif = {
        package = pkgs.source-han-serif;
        name = "Source Han Serif";
      };
      sansSerif = {
        package = pkgs.source-han-sans;
        name = "Source Han Sans Serif";
      };
      monospace = { 
        package = pkgs.nerd-fonts.inconsolata;
        name = "Inconsolata Font Mono";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
    cursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
    };
  };
}
