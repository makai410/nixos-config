{...}: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "gh-makai410" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
        addKeysToAgent = "yes";
      };
      "gh-mystery" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519_gh_mystery";
        addKeysToAgent = "yes";
      };
    };
  };

  services.ssh-agent.enable = true;
}
