{
  services.logind.settings.Login = {
    HandleLidSwitch = "hibernate";
    HandlePowerKey = "ignore";
  };
  networking.networkmanager.wifi.powersave = true;
}
