{ pkgs, user, ... }:
{
  home.packages = with pkgs; [ nvd ];
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza --icons --group-directories-first -s Name";
      l = "eza --icons --group-directories-first -s Name";
      ll = "eza -1lh --icons --group-directories-first -s Name --time-style long-iso";
      la = "eza -1lah --icons --group-directories-first -s Name --time-style long-iso";
      gd = "git diff";
      gds = "git diff --staged";
      gs = "git status";
      gss = "git status --staged";
      gc = "git commit -m";
      gca = "git commit --amend";
      gpf = "git push -f";
      gcb = "git switch -c";
      gbc = "git switch -c";
      fiowrite = "fio --rw=write --bs=4k --size=5G --name=seqwrite --ioengine=posixaio --runtime=60 --end_fsync=1";
      fioread = "fio --rw=read --bs=4k --size=5G --name=seqread --ioengine=posixaio --runtime=60 --end_fsync=1";
      fiorandwrite = "fio --rw=randwrite --bs=4k --size=5G --name=randwrite --ioengine=posixaio --runtime=60 --end_fsync=1";
      fiorandread = "fio --rw=randread --bs=4k --size=5G --name=randread --ioengine=posixaio --runtime=60 --end_fsync=1";
      lzg = "lazygit";
    };

    shellInit = ''
      set -g theme_display_vi no
      set -g theme_display_date no
      set -g theme_nerd_fonts yes
      set -g theme_powerline_fonts yes
      set -g theme_color_scheme dark
      set -x VIRTUAL_ENV_DISABLE_PROMPT 1
      set -x EDITOR nvim
      set -x IMG_VIEWER imv-dir
      set -x NNN_FIFO /tmp/nnn.fifo
    '';
    loginShellInit = ''
      if test (tty) = /dev/tty1
        if type -q sway
          exec sway
        else if type -q niri-session
          exec niri-session
        else if type -q Hyprland
          exec /home/${user}/.local/bin/wrappedhl
        else
          XDG_SESSION_TYPE=wayland exec dbus-run-session gnome-session
        end
      end
    '';
    functions = {
      fish_greeting = "";
      wav2flac = ''
        set ORIGINAL_SIZE (du -hs | cut -f1)

        fd -e wav -x ffmpeg -i "{}" -loglevel quiet -stats "{.}.flac"
        fd -e wav -X rm -I

        set NEW_SIZE (du -hs | cut -f1)

        echo "Done. Reduced file size from $ORIGINAL_SIZE to $NEW_SIZE"
      '';
      nixdiff = ''
        nvd diff /nix/var/nix/profiles/system-$argv[1]-link /nix/var/nix/profiles/system-$argv[2]-link
      '';
      extractzip = ''
        fd -e zip -x sh -c 'unzip -o -d "''${0%.*}" "$0"' '{}' ';'
      '';
    };

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
