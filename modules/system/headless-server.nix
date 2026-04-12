{lib, ...}: {
  # Disable all sleep/suspend/hibernate targets by default
  systemd.targets = {
    sleep.enable = lib.mkDefault false;
    suspend.enable = lib.mkDefault false;
    hibernate.enable = lib.mkDefault false;
    hybrid-sleep.enable = lib.mkDefault false;
  };
}
