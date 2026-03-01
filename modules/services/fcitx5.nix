{ pkgs, lib, config, ... }:
{
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      addons = with pkgs; [ fcitx5-rime fcitx5-mozc fcitx5-hangul fcitx5-fluent ];
      settings = {
        addons = {
          classicui.globalSection.Theme = "FluentDark";
          classicui.globalSection.DarkTheme = "FluentDark";
        };      
      };
    };
  };
  environment.sessionVariables = {
    NIX_PROFILES =
      "${lib.concatStringsSep " " (lib.reverseList config.environment.profiles)}";
    XMODIFIERS = "@im=fcitx";
    QT_IM_MODULE = "fcitx";
    GTK_IM_MODULE = "fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "ibus"; # for some apps
  };
}
