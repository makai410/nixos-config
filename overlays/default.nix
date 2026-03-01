# This file defines overlays
{inputs, ...}:
let
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    qq = prev.qq.override { commandLineArgs = [ "--wayland-text-input-version=3" "--enable-wayland-ime" ]; };
    vesktop = prev.vesktop.override { commandLineArgs = [ "--wayland-text-input-version=3" "--enable-wayland-ime" ]; };
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };
in
{
  nixpkgs.overlays = [
    additions
    modifications
    inputs.niri.overlays.niri
    inputs.fenix.overlays.default

    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  ];
}