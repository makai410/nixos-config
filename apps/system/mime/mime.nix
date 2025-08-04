{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ xdg-utils ];
  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = {
      enable = true;
    };
  };
}
