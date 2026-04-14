{
  lib,
  inputs,
  user,
  config,
  pkgs,
  ...
}: {
  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      substituters = [
        "https://mirror.sjtu.edu.cn/nix-channels/store" # SJTU
        "https://mirrors.ustc.edu.cn/nix-channels/store" # USTC
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" # Tsinghua
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
      trusted-users = [
        "root"
        "${user}"
      ];
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
    ];
  };
  nixpkgs.config = {
    # Disable if you don't want unfree packages
    allowUnfree = true;
  };
}
