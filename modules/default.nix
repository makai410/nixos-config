{
  lib,
  inputs,
  ...
}: let
  modules = {
    # Mdoules related to system/services
    laptop = {
      system = [
        ./services/laptop.nix
      ];
    };
    desktop = {
      system = [
        ./system/bluetooth.nix
        ./system/hibernate.nix
        ./services/pipewire.nix
        ./services/ppd.nix
      ];
      home = [
      ];
    };
    headless-server = {
      system = [
        ./system/headless-server.nix
      ];
    };
    bootloader-systemd-boot = {
      system = [
        ./system/bootloader-systemd-boot.nix
      ];
    };
    dae = {
      system = [
        ./services/dae.nix
      ];
    };
    # User apps
    alacritty = {
      home = [
        ./apps/alacritty/alacritty.nix
      ];
    };
    catppuccin = {
      home = [
        inputs.catppuccin.homeModules.catppuccin
        ./apps/catppuccin/catppuccin.nix
      ];
    };
    udiskie = {
      system = [
        ./apps/udiskie/default.nix
      ];
      home = [
        ./apps/udiskie/udiskie.nix
      ];
    };
    easytier = {
      system = [
        ./apps/easytier/default.nix
      ];
    };
    gitui = {
      home = [
        ./apps/gitui/gitui.nix
      ];
    };
    ssh = {
      home = [
        ./apps/ssh/ssh.nix
      ];
    };
    steam = {
      system = [
        ./apps/steam/default.nix
      ];
      home = [
        ./apps/steam/steam.nix
      ];
    };
  };
in
  modules
  // {
    getSystemModules = profiles:
      lib.concatMap (
        profile:
          profile.system or []
      )
      profiles;

    getHomeModules = profiles:
      lib.concatMap (
        profile:
          profile.home or []
      )
      profiles;

    commonApps = with modules; [
      alacritty
      catppuccin
      easytier
      niri
    ];
  }
