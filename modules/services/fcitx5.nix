{
  pkgs,
  lib,
  config,
  ...
}: {
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        qt6Packages.fcitx5-chinese-addons
        fcitx5-gtk
        fcitx5-mozc
        fcitx5-hangul
        fcitx5-fluent
      ];
      settings = {
        addons = {
          classicui.globalSection.Theme = "FluentDark";
          classicui.globalSection.DarkTheme = "FluentDark";
        };
      };
    };
  };

  environment.sessionVariables = {
    NIX_PROFILES = "${lib.concatStringsSep " " (lib.reverseList config.environment.profiles)}";

    QT_IM_MODULE = "fcitx";
    GTK_IM_MODULE = "fcitx";

    # XWayland
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";

    # GLFW
    GLFW_IM_MODULE = "ibus"; # for some apps
  };
}
