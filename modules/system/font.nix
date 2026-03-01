{pkgs, ...}:
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      source-han-serif          # 思源宋体
      nerd-fonts.inconsolata    # Inconsolata Nerd Font
      nerd-fonts.symbols-only   # just the icons if needed elsewhere
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Source Han Serif SC" "Noto Serif" ];
        sansSerif = [ "Noto Sans" "Noto Sans CJK SC" ];
        monospace = [ "Inconsolata Nerd Font" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
};
}