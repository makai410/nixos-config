{
  lib,
  inputs,
}:
let
  modules = {
    laptop = {
      system = [
        ./services/laptop.nix
        ./services/laptop-tlp.nix
      ];
      bootloader-systemd-boot = {
        system = [
          ./services/bootloader-systemd-boot.nix
        ];
      };
      catppuccin = {
        home = [
          inputs.catppuccin.homeModules.catppuccin
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
    };
  };
in modules //
{
  getSystemModules = profiles: lib.concatMap (profile:
    if modules ? ${profile} && modules.${profile} ? system 
    then modules.${profile}.system else []
  ) profiles;

  getHomeModules = profiles: lib.concatMap (profile:
    if modules ? ${profile} && modules.${profile} ? home 
    then modules.${profile}.home else []
  ) profiles;
}