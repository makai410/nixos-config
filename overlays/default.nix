# This file defines overlays
{inputs, ...}: let
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    vesktop = prev.vesktop.override {commandLineArgs = ["--wayland-text-input-version=3" "--enable-wayland-ime"];};
    steam = prev.steam.override {commandLineArgs = ["--wayland-text-input-version=3" "--enable-wayland-ime"];};
    noctalia-shell = prev.noctalia-shell.override {calendarSupport = true;};
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };
in {
  nixpkgs.overlays = [
    additions
    modifications
    inputs.niri.overlays.niri
  ];
}
