{
  pkgs,
  user,
  stateVersion,
  inputs,
  ...
}:
{
  # Shared packages
  home.packages = with pkgs; [
    btop
    htop
    gh
    telegram-desktop
    zulip
    clash-verge-rev
    zotero_7
    qq
    tinymist
    typst
    ouch
    vesktop
  ];

  home.username = user;
  home.homeDirectory = "/home/${user}";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = hostConfig.stateVersion;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}