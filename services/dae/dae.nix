{ ... }:
{
  services.dae = {
    configFile = "$HOME/.config/dae/config.dae";
    enable = true;
  };                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              

  home.file = {
    ".config/dae".source = ../dae;
  };
}
