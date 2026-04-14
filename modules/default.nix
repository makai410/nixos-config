{
  lib,
  inputs,
  ...
}: let
  mkAppInner = config: {
    system = (if builtins.pathExists ./apps/${config.app}/default.nix 
    then [ ./apps/${config.app}/default.nix ] else [])
    ++ config.extraSystemModules;
    home = (if builtins.pathExists ./apps/${config.app}/${config.app}.nix 
    then [ ./apps/${config.app}/${config.app}.nix ] else [])
    ++ config.extraHomeModules;
  };
  mkApp = app: (mkAppInner {
    inherit app;
    extraSystemModules = [];
    extraHomeModules = [];
  });
  modules = {
    # Mdoules related to system/services
    basic = {
      system = [
        ./system/os-modules.nix
        ./system/networking.nix
        ./system/font.nix
        ./system/graphics.nix
        ./services/openssh.nix
        ./system/i18n.nix
      ];
    };
    bootloader-systemd-boot = {
      system = [
        ./system/bootloader-systemd-boot.nix
      ];
    };
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
    dae = {
      system = [
        ./services/dae.nix
      ];
    };
    fcitx5 = {
      system = [
        ./services/fcitx5.nix
      ];
    };
    sops = {
      system = [
        ./system/sops.nix
      ];
    };

    # User apps
    alacritty = mkApp "alacritty";
    bat = mkApp "bat";
    catppuccin = mkAppInner {
      app = "catppuccin";
      extraSystemModules = [];
      extraHomeModules = [
        inputs.catppuccin.homeModules.catppuccin
      ];
    };
    cliphist = mkApp "cliphist";
    direnv = mkApp "direnv";
    easytier = mkApp "easytier";
    fastfetch = mkApp "fastfetch";
    firefox = mkApp "firefox";
    fish = mkApp "fish";
    git = mkApp "git";
    gitui = mkApp "gitui";
    helix = mkApp "helix";
    imv = mkApp "imv";
    mime = mkApp "mime";
    niri = mkApp "niri";
    noctalia = mkApp "noctalia";
    obs = mkApp "obs";
    python = mkApp "python";
    ssh = mkApp "ssh";
    steam = mkApp "steam";
    udiskie = mkApp "udiskie";
    yazi = mkApp "yazi";
    zellij = mkApp "zellij";
    zoxide = mkApp "zoxide";
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

    commonDesktopApps = with modules; [
      alacritty
      bat
      catppuccin
      cliphist
      direnv
      fastfetch
      firefox
      fish
      git
      gitui
      helix
      imv
      mime
      niri
      noctalia
      obs
      python
      ssh
      steam
      udiskie
      yazi
      zellij
      zoxide
    ];
  }
