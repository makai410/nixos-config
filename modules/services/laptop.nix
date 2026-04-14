{
  services.logind = {
    lidSwitch = "hibernate";
    powerKey = "ignore";
  };
  networking.networkmanager.wifi.powersave = true;
}
