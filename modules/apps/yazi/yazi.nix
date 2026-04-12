{pkgs, ...}: {
  home.packages = with pkgs; [
    ouch # archive
    ffmpeg # video
    jq # json
    poppler_utils # pdf
    fd # file search
    ripgrep # content search
    fzf # fuzzy selection
    resvg # svg
    imagemagick # image
  ];
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    flavors = {
      foo = ./foo;
      inherit (pkgs.yaziPlugins) bar;
    };
    keymap = {
      mgr.prepend_keymap = [
        {
          on = "C";
          run = "plugin ouch";
          desc = "Compress with ouch";
        }
        {
          on = "F";
          run = "plugin fzf";
          desc = "Fuzzy find";
        }
        {
          on = "o";
          run = "plugin open-with-cmd --args=block";
          desc = "Open with...";
        }
      ];
    };
    settings = {
      yazi = {
        ratio = [
          1
          4
          3
        ];
        sort_by = "natural";
        sort_sensitive = true;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "none";
        show_hidden = true;
        show_symlink = true;
      };
      preview = {
        image_filter = "lanczos3";
        image_quality = 90;
        tab_size = 1;
        max_width = 600;
        max_height = 900;
        cache_dir = "";
        ueberzug_scale = 1;
        ueberzug_offset = [
          0
          0
          0
          0
        ];
      };
      tasks = {
        micro_workers = 5;
        macro_workers = 10;
        bizarre_retry = 5;
      };
    };
  };
}
