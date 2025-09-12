{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    nautilus
    firefox
    shotcut
  ];
}
