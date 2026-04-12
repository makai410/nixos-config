{
  pkgs,
  user,
  ...
}: {
  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Opinionated: use keys only.
      # Remove if you want to SSH using passwords
      PasswordAuthentication = false;
    };
  };

  users.users.${user}.openssh.authorizedKeys.keyFiles = [
    (pkgs.fetchurl {
      url = "https://github.com/makai410.keys";
      sha256 = "10grsx4dgzcrhsqhwjw9c5ig841svv1pcwhdr2c67pw1x7rwiybd";
    })
  ];
}
