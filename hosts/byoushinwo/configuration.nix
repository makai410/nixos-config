# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  lib,
  pkgs,
  user,
  stateVersion,
  ...
}: {
  time.timeZone = "Asia/Shanghai";
  console.keyMap = "us";

  services.gnome.gnome-keyring.enable = true;
  services.fstrim.enable = true;
  services.journald.extraConfig = ''
    SystemMaxUse=50M
    SystemMaxFileSize=10M
    RuntimeMaxUse=50M
    RuntimeMaxFileSize=10M
  '';
  services.gvfs.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # FIXME: Add the rest of your current configuration

  users.mutableUsers = lib.mkDefault true;
  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users.${user} = {
    # TODO: You can set an initial password for your user.
    # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
    # Be sure to change it (using passwd) after rebooting!
    initialPassword = "correcthorsebatterystaple";
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
    ];
    # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
    extraGroups = ["wheel"];
    shell = "${pkgs.fish}/bin/fish";
  };

  # Intel GPU (Arc/Xe)
  services.xserver.videoDrivers = ["modesetting"];

  # Thinkpad specific
  services.throttled.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "${stateVersion}";
}
