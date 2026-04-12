{
  user,
  hostName,
  ...
}: {
  networking = {
    inherit hostName;
    networkmanager = {
      enable = true;
      dns = "none";
    };
    nameservers = ["130.161.158.4" "130.161.33.17"]; # FIXME
  };
  users.users.${user}.extraGroups = ["networkmanager"];
}
