{ config, lib, ... }:

{
  imports = [ (lib.tf.provider "hetznercloud_hcloud") ];

  variable.networks.type = "map(string)";

  resource.hcloud_server.web = {
    name = "web";
    server_type = "cx23";
    # a block per variable entry, typed like a literal `network` block
    dynamic.network = {
      for_each = config.variable.networks;
      content.network_id = "\${network.value}";
    };
  };
}
