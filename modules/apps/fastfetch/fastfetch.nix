{
  programs.fastfetch = {
    enable = true;
  };

  home.file = {
    ".config/fastfetch".source = ./config;
    "Pictures/fastfetch_logos" = {
      source = ./config/nixos.png;
      recursive = true;
    };
  };
}
