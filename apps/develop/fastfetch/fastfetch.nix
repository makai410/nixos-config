{
  programs.fastfetch = {
    enable = true;
  };

  home.file = {
    ".config/fastfetch".source = ../fastfetch;
    "Pictures/fastfetch_logos" = {
      source = ../../../assets/fastfetch;
      recursive = true;
    };
  };
}
