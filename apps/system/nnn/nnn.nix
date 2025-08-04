{ pkgs, ... }:
{
  programs.nnn = {
    enable = true;

    bookmarks = {
      h = "~";
      e = "~/nfs/Expansion/Downloads";
      t = "~/Downloads";
      d = "~/Documents";
      f = "~/nfs";
      m = "~/nfs/WDC14/Music";
    };
    plugins = {
      mappings = {
        a = "autojump";
        c = "fzcd";
        f = "finder";
        v = "imgview";
        p = "preview-tui";
        x = "togglex";
      };
      src =
        (pkgs.fetchFromGitHub {
          owner = "jarun";
          repo = "nnn";
          rev = "v5.0";
          sha256 = "sha256-HShHSjqD0zeE1/St1Y2dUeHfac6HQnPFfjmFvSuEXUA=";
        })
        + "/plugins";
    };
  };
}
