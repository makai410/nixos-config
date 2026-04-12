{
  inputs,
  user,
  ...
}: {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    age.keyFile = "/home/${user}/.config/sops/age/keys.txt";
    secrets = {
      ssh-makai410 = {
        owner = user;
        path = "/home/${user}/.ssh/id_ed25519";
        mode = "0600";
      };
      ssh-gh-mystery = {
        owner = user;
        path = "/home/${user}/.ssh/id_ed25519_gh_mystery";
        mode = "0600";
      };
      proxy-sub-v2ray = {};
    };
  };
}
