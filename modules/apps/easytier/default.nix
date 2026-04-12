{
  services.easytier = {
    enable = true;

    instances.common = {
      settings = {
        networkName = "makai_private_net";

        environmentFiles = [
          "/etc/easytier/common.env"
        ];

        peers = [
          "tcp://public.easytier.top:11010"
          # You can add more public nodes or a self-hosted VPS node here if needed
        ];
      };
    };
  };

  networking.firewall.allowedTCPPorts = [11010];
  networking.firewall.allowedUDPPorts = [11010];
}
