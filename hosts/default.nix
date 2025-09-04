{
  lib,
  inputs,
  user,
  ...
}:
let
  moduleProfiles = {
    laptop = {
      system = [
        ../services/common/laptop.nix
        ../services/common/laptop-tlp.nix
      ];
    };
    bootloader-systemd-boot = {
      system = [                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
        ../services/common/bootloader-systemd-boot.nix
      ];
    };
    bootloader-systemd-boot-asahi = {
      system = [
        ../services/common/bootloader-systemd-boot-asahi.nix
      ];
    };
    bootloader-grub = {
      system = [
        ../services/common/bootloader-grub-uefi.nix
      ];
    };
    niri = {
      system = [
        ../apps/gui/niri/default.nix
        ../apps/gui/hyprlock/default.nix
      ];
      home = [
        inputs.niri.homeModules.niri
        inputs.niri.homeModules.stylix
        ../apps/gui/niri/niri.nix
        ../apps/gui/hyprlock/hyprlock.nix
        ../apps/gui/hypridle/hypridle.nix
        ../apps/gui/anyrun/anyrun.nix
        ../apps/gui/waybar/waybar.nix
        ../apps/gui/mako/mako.nix
        ../apps/gui/gammastep/gammastep.nix
      ];
    };
    steam = {
      system = [
        ../services/common/xbox.nix
        ../apps/misc/steam/default.nix
      ];
      home = [ ../apps/misc/steam/steam.nix ];
    };
    python = {
      home = [
        ../apps/develop/direnv/direnv.nix
        ../apps/develop/python/python.nix
      ];
    };
    vscode = {
      home = [
        ../apps/develop/vscode/vscode.nix
      ];
    };
    obs = {
      home = [ ../apps/misc/obs/obs.nix ];
    };
    zen-browser = {
      home = [ ../apps/misc/zen-browser/zen-browser.nix ];
    };
  };

  mkHost =
    {
      hostName,
      stateVersion,
      system ? "x86_64-linux",
      profiles ? [ ],
      extraModules ? [ ],
      extraHomeModules ? [ ],
      homeConfig ? ../hosts/${hostName}/home.nix,
      baseConfig ? ../configuration.nix,
    }:
    let
      # Extract system modules from profiles
      systemModules = lib.concatMap (
        profile:
        if moduleProfiles ? ${profile} && moduleProfiles.${profile} ? system then
          moduleProfiles.${profile}.system
        else
          [ ]
      ) profiles;

      # Extract home-manager modules from profiles
      homeModules = lib.concatMap (
        profile:
        if moduleProfiles ? ${profile} && moduleProfiles.${profile} ? home then
          moduleProfiles.${profile}.home
        else
          [ ]
      ) profiles;
    in
    lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit
          user
          inputs
          hostName
          stateVersion
          ;
      };
      modules =
        [
          baseConfig
          ../services/overlays.nix
          ../services/cachix/cachix.nix
          inputs.stylix.nixosModules.stylix
          ../apps/gui/stylix/default.nix
          ../apps/system/udiskie/default.nix
          ../apps/system/fcitx5/default.nix
          ../apps/system/dae/default.nix
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit
                  user
                  inputs
                  system
                  stateVersion
                  ;
                selectedProfiles = profiles;
              };
              users.${user} = {
                imports =
                  [
                    ../hosts/common.nix
                    ../apps/gui/stylix/stylix.nix
                    ../apps/develop/git/git.nix
                    ../apps/develop/lazygit/lazygit.nix
                    ../apps/develop/fish/fish.nix
                    ../apps/develop/kitty/kitty.nix
                    ../apps/develop/fastfetch/fastfetch.nix
                    ../apps/system/nnn/nnn.nix
                    ../apps/system/yazi/yazi.nix
                    ../apps/system/udiskie/udiskie.nix
                    ../apps/system/mime/mime.nix
                    ../apps/system/imv/imv.nix
                    ../apps/system/bat/bat.nix
                    ../apps/system/zoxide/zoxide.nix
                    ../apps/system/zathura/zathura.nix
                    ../apps/system/tealdeer/tealdeer.nix
                    homeConfig
                  ]
                  ++ homeModules
                  ++ extraHomeModules;
              };
            };
          }
          ../hosts/${hostName}/hardware-configuration.nix
        ]
        ++ systemModules
        ++ extraModules;
    };
in
{
  pc-ztmy = mkHost {
    hostName = "pc-ztmy";
    stateVersion = "25.05";
    profiles = [
      "bootloader-systemd-boot"
      "niri"
      "steam"
      "zen-browser"
      "chromium"
      "obs"
      "python"
    ];
    extraModules = [
      inputs.nixos-hardware.nixosModules.common-cpu-amd
      inputs.nixos-hardware.nixosModules.common-gpu-amd
      {
        my.stylix.wallpaper = "acane_washmachine";
      }
    ];
    extraHomeModules = [
    ];
  };

  tkbook = mkHost {
    hostName = "tkbook";
    stateVersion = "25.05";
    profiles = [
      "laptop"
      "bootloader-systemd-boot"
      "niri"
      "steam"
      "zen-browser"
      "chromium"
      "obs"
      "python"
    ];
    extraModules = [
      inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
      inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
      {
        my.stylix.wallpaper = "acane_washmachine";
      }
    ];
    extraHomeModules = [
    ];
  };

  e14-lnl = mkHost {
    hostName = "e14-lnl";
    stateVersion = "25.05";
    profiles = [
      "laptop",
      "bootloader-systemd-boot",
      "niri"
      "steam"
      "zen-browser"
      "chromium"
      "obs"
      "python"
    ];
    extraModules = [
      # It's lunar lake
      inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-13th-gen
      {
        my.stylix.wallpaper = "acane_washmachine";
      }
    ];
    extraHomeModules = [
    ];
  };
}
