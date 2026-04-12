{
  lib,
  inputs,
  user,
  ...
}: let
  mods = import ../modules {
    inherit lib inputs;
  };
  inherit
    (mods)
    commonApps
    getSystemModules
    getHomeModules
    ;
  hosts = {
    # Home PC
    youshinron = {
      system = "x86_64-linux";
      stateVersion = "25.05";
      profiles = with mods; [
        bootloader-systemd-boot
        headless-server
      ];
      extraSystemModules = [
      ];
      extraHomeModules = [
        {programs.niri.settings.mouse.accel-speed = -0.4;}
      ];
      specialisation = {
        desktop = {
          profiles = with mods; [
            desktop
            niri
            catppuccin
          ];
          extraSystemModules = [
            inputs.nixos-hardware.nixosModules.common-cpu-amd
            inputs.nixos-hardware.nixosModules.common-gpu-amd
          ];
        };
      };
    };

    # ThinkPad Laptop
    byoushinwo = {
      system = "x86_64-linux";
      stateVersion = "25.05";
      profiles = with mods; [
        laptop
        desktop
        bootloader-systemd-boot
      ];
      extraSystemModules = [
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-e14-intel-gen7-lnl
        inputs.nix-minecraft.nixosModules.minecraft-servers
      ];
      extraHomeModules = [
        {programs.niri.settings.mouse.accel-speed = -0.5;}
      ];
      specialisation = {
      };
    };

    # TODO: Jtti Japan VPS (nixos-anywhere)
  };
in {
  nixosConfigurations =
    lib.mapAttrs (
      hostName: hostConfig:
        lib.nixosSystem {
          system = hostConfig.system;
          specialArgs = {
            inherit
              user
              inputs
              hostName
              ;
            inherit (hostConfig) stateVersion;
          };
          modules =
            [
              inputs.self.overlays

              ../hosts/${hostName}/configuration.nix
              ../hosts/${hostName}/hardware-configuration.nix

              ../modules/system/font.nix
              ../modules/system/os-modules.nix
              ../modules/system/i18n.nix
              ../modules/system/networking.nix
              ../modules/system/sops.nix

              ../modules/services/openssh.nix
              ../modules/services/dae.nix
              ../modules/services/fcitx5.nix

              {
                specialisation =
                  lib.mapAttrs (
                    specName: specConfig: let
                      configuration = {
                        system.nixos.tags = ["${specName}"];
                        imports =
                          (getSystemModules specConfig.profiles)
                          ++ specConfig.extraSystemModules;
                      };
                    in {
                      inherit configuration;
                    }
                  )
                  hostConfig.specialisation;
              }
            ]
            ++ (getSystemModules commonApps)
            ++ (getSystemModules hostConfig.profiles)
            ++ hostConfig.extraSystemModules;
        }
    )
    hosts;

  homeConfigurations =
    lib.mapAttrs' (
      hostName: hostConfig:
        lib.nameValuePair "${user}@${hostName}" (
          inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = inputs.nixpkgs.legacyPackages.${hostConfig.system};
            extraSpecialArgs = {
              inherit
                user
                inputs
                hostName
                ;
              inherit
                (hostConfig)
                system
                stateVersion
                ;
            };
            modules =
              [
                inputs.self.overlays
                ../hosts/hm-manager.nix
                ../hosts/${hostName}/home.nix
              ]
              ++ (getHomeModules commonApps)
              ++ (getHomeModules hostConfig.profiles)
              ++ hostConfig.extraHomeModules;
          }
        )
    )
    hosts;
}
