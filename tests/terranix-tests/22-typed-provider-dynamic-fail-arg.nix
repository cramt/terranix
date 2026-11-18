{ config, lib, ... }:

{
  imports = [ (lib.tf.provider "hetznercloud_hcloud") ];

  variable.networks.type = "map(string)";

  resource.hcloud_server.web = {
    name = "web";
    server_type = "cx23";
    dynamic.network = {
      for_each = config.variable.networks;
      content.network_idd = "\${network.value}";
    };
  };
}
