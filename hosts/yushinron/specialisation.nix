{
  lib,
  config,
  pkgs,
  modules,
}:
{
  # Desktop mode
  specialisation = {
    desktop.configuration = {
      imports = modules;

      # This tag will show up in your bootloader menu
      system.nixos.tags = [ "desktop-gui" ];

      # 1. Re-enable sleep and suspend for normal PC usage
      systemd.targets = {
        sleep.enable = true;
        suspend.enable = true;
        hibernate.enable = true;
        hybrid-sleep.enable = true;
      };
      
      # Example: Enable Audio
      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;  # for pulseaudio compatibility
        jack.enable = true;   # optional, for jack compatibility
      };
    };
  };
}