{
  lib,
  inputs,
  user,
  nixpkgsOverlays,
  ...
}: let
  mods = import ../modules {
    inherit lib inputs;
  };
  inherit
    (mods)
    commonDesktopApps
    getSystemModules
    getHomeModules
    ;
  hosts = {
    # Home PC
    youshinron = {
      system = "x86_64-linux";
      stateVersion = "25.05";
      profiles = with mods; [ # TODO
        basic
        bootloader-systemd-boot
        headless-server
      ];
      extraSystemModules = [
        inputs.nixos-hardware.nixosModules.common-cpu-amd
        inputs.nixos-hardware.nixosModules.common-gpu-amd
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
          extraSystemModules = [];
        };
      };
    };

    # ThinkPad Laptop
    byoushinwo = {
      system = "x86_64-linux";
      stateVersion = "25.05";
      profiles = with mods; [
        basic
        bootloader-systemd-boot
        laptop
        desktop
        dae
        fcitx5
        sops
      ] ++ commonDesktopApps;
      extraSystemModules = [
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-e14-intel-gen7-lnl
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
              nixpkgsOverlays
              ../hosts/${hostName}/configuration.nix
              ../hosts/${hostName}/hardware-configuration.nix
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
                nixpkgsOverlays
                ../hosts/hm-manager.nix
                ../hosts/${hostName}/home.nix
              ]
              ++ (getHomeModules hostConfig.profiles)
              ++ hostConfig.extraHomeModules;
          }
        )
    )
    hosts;
}
