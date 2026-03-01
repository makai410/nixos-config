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
        { services.easytier.instances.common.ipv4 = "10.144.144.10"; }
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
        { services.easytier.instances.common.ipv4 = "10.144.144.11"; }
      ];
    };
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
        inputs.self.overlays
        ../hosts/${hostName}/configuration.nix
        ../hosts/${hostName}/hardware-configuration.nix
        ../modules/system/font.nix
        ../modules/services/bluetooth.nix
        ../modules/services/dae.nix
        ../modules/services/fcitx5.nix
        ../modules/fenix/default.nix
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
          inputs.self.overlays
          ../hosts/hm-manager.nix
          ../hosts/${hostName}/home.nix
        ]
        ++ (getHomeModules hostConfig.profiles);
      }
    )
  ) hosts;
}