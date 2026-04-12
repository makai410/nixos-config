{pkgs, ...}: {
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    configPackages = [
      pkgs.niri-unstable
    ];
    config.niri = {
      "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
    };
  };
}
