{
  lib,
  inputs,
  user,
  ...
}:
let
  modules = import ../modules {
    inherit lib;
  };
  hosts = {
    # Home PC
    "youshinron" = {
      system = "x86_64-linux";
      stateVersion = "25.05";
      profiles = [
        "bootloader-systemd-boot"
        "niri"
        "easytier"
        "catppuccin"
      ];
      extraSystemModules = [
        { my.stylix.wallpaper = "acane_washmachine"; }
      ];
    };

    # ThinkPad Laptop
    "byoushinwo" = {
      system = "x86_64-linux";
      stateVersion = "25.05";
      profiles = [
        "laptop"
        "bootloader-systemd-boot"
        "niri"
        "easytier"
        "catppuccin"
      ];
      extraSystemModules = [
        { my.stylix.wallpaper = "acane_washmachine"; }
      ];
    };

    #TODO: nix-on-droid :))))
  };
in
{
  nixosConfigurations = lib.mapAttrs (hostName: hostConfig:
    lib.nixosSystem {
      system = hostConfig.system;
      specialArgs = {
        inherit
          user
          inputs
          hostName
          ;
        stateVersion = hostConfig.stateVersion;
      };
      modules = [
        ../hosts/${hostName}/configuration.nix
        ../hosts/${hostName}/hardware-configuration.nix
        ../modules/services/bluetooth.nix
        ../modules/services/dae.nix
        ../modules/services/fcitx5.nix
      ]
      ++ (getSystemModules hostConfig.profiles)
      ++ hostConfig.extraSystemModules;
    }
  ) hosts;

  homeConfigurations = lib.mapAttrs (hostName: hostConfig:
    lib.nameValuePair "${user}@${hostName}" (
      inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.${hostConfig.system};
        extraSpecialArgs = {
          inherit
            user
            inputs
            hostName
          ;
          system = hostConfig.system;
          stateVersion = hostConfig.stateVersion;
          selectedProfiles = hostConfig.profiles;
        };
        modules = [
          ../hosts/hm-manager.nix
          ../hosts/${hostName}/home.nix
        ]
        ++ (getHomeModules hostConfig.profiles);
      }
    )
  ) hosts;
}