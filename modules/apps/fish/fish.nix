{ pkgs, user, ... }:
{
  home.packages = with pkgs; [ nvd ];
  programs.fish = {
    enable = true;

    shellInit = ''
      set -g theme_display_vi no
      set -g theme_display_date no
      set -g theme_display_user ssh
      set -g theme_display_hostname ssh
      set -g theme_display_sudo_user yes
      set -g theme_nerd_fonts yes
      set -g theme_powerline_fonts yes
      set -g theme_color_scheme dark
      set -x VIRTUAL_ENV_DISABLE_PROMPT 1
      set -x EDITOR hx
    '';
    loginShellInit = ''
      if test (tty) = /dev/tty1
        if type -q niri-session
          exec niri-session
        end
      end
    '';

    plugins = [
      {
        name = "bobthefish";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "theme-bobthefish";
          rev = "c2c47dc964a257131b3df2a127c2631b4760f3ec";
          sha256 = "sha256-LB4g+EA3C7OxTuHfcxfgl8IVBe5NufFc+5z9VcS0Bt0=";
        };
      }
    ];
  };
}
