{
  lib,
  user,
  ...
}:
{
  networking.networkmanager.enable = true;
  users.users.${user}.extraGroups = lib.mkMerge [[ "networkmanager" ]];
}