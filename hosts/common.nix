{
  pkgs,
  user,
  stateVersion,
  ...
}:
{
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
  home.stateVersion = "${stateVersion}";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  services.mpris-proxy.enable = true;

  home.packages = with pkgs; [
    brightnessctl
    btop
    cachix
    eza
    fd
    ffmpeg
    ffmpegthumbnailer
    gnome-system-monitor
    htop
    imagemagick
    jq
    just
    keepassxc
    libreoffice-fresh
    ncdu
    nitch
    neovim
    pavucontrol
    ripgrep
    ripgrep-all
    unzip
    rustup
    telegram-desktop
    zulip
    clash-verge-rev
    zotero_7
    vscode
    gcc
    qq
    (symlinkJoin {
      name = "vesktop";
      paths = [ vesktop ];
      buildInputs = [ makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/vesktop --add-flags "--wayland-text-input-version=3"
      '';
    })
    rnote
    (
      let
        base = pkgs.appimageTools.defaultFhsEnvArgs;
      in
      pkgs.buildFHSEnv (
        base
        // {
          name = "fhs";
          targetPkgs =
            pkgs:
            (base.targetPkgs pkgs)
            ++ (with pkgs; [
              pkg-config
            ]);
          profile = "export FHS=1";
          runScript = "fish";
          extraOutputsToInstall = [ "dev" ];
        }
      )
    )
  ];
}
