{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts-color-emoji
      ibm-plex # IBM Plex Sans
      source-han-serif # 思源宋体
      nerd-fonts.inconsolata # Inconsolata Nerd Font
      meslo-lgs-nf # Tide Required
      nerd-fonts.symbols-only # just the icons if needed elsewhere
    ];

    fontconfig = {
      defaultFonts = {
        serif = ["Source Han Serif SC" "IBM Plex Serif" "Source Han Serif"];
        sansSerif = ["IBM Plex Sans Chinese SC" "IBM Plex Sans"];
        monospace = ["Inconsolata Nerd Font" "MesloLGS NF"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
