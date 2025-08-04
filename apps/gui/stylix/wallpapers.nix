{ pkgs, ... }:
{
  # Available scaling modes: stretch, fill, fit, center, tile
  wallpapers = {
    "warma-moon" = {
      image = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/makai410/imgs/refs/heads/main/warma-moon.jpg";
        sha256 = "Bot4OOfi84RTQQnPzhfUZNwNGtAcN/gtprhY7lbQDEI=";
      };
      imageScalingMode = "fill";
    };
    "hippocampal_pain" = {
      image = ../../../assets/wallpapers/hippocampal_pain.png;
      imageScalingMode = "fill";
    };
  };
  defaultWallpaper = "warma-moon";
}
