# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    qq = prev.qq.overrideAttrs { commandLineArgs = [ "--wayland-text-input-version=3" ]; };
    steam = prev.steam.override { commandLineArgs = [ "--wayland-text-input-version=3" ]; };
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };
}
