{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    nautilus
    shotcut
  ];
}
