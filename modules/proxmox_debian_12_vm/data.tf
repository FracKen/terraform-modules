data "proxmox_virtual_environment_nodes" "available_nodes" {}

data "http" "checksum_file" {
  method = "GET"
  url    = "https://cloud.debian.org/images/cloud/bookworm/latest/SHA512SUMS"
}

resource "random_integer" "index" {
  min = 0
  max = length(data.proxmox_virtual_environment_nodes.available_nodes.names) - 1
}

data "proxmox_virtual_environment_datastores" "datastores" {
  node_name = element(data.proxmox_virtual_environment_nodes.available_nodes.names,random_integer.index.result)
}