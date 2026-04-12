{pkgs, ...}: {
  home.packages = with pkgs; [nvd];
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
    shellAliases = {
      y = "yazi";
      gca = "git commit --amend";
    };
    plugins = [
      {
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
      }
    ];
  };
  programs.man.generateCaches = false;
}
