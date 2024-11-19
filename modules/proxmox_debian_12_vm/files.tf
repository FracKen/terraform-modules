resource "proxmox_virtual_environment_download_file" "debian_cloud_image" {
  # for_each = toset(data.proxmox_virtual_environment_nodes.available_nodes.names)
  node_name          = element(data.proxmox_virtual_environment_nodes.available_nodes.names, random_integer.index.result)
  content_type       = "iso"
  datastore_id       = local.datastore_iso
  url                = "https://cloud.debian.org/images/cloud/bookworm/latest/${var.vm_image_name}"
  checksum           = local.sha512_hash
  checksum_algorithm = "sha512"
  file_name          = "${replace(var.vm_image_name, ".", "-")}.img"
  overwrite          = true
}

resource "proxmox_virtual_environment_file" "debian_vendor_config" {
  # for_each = toset(data.proxmox_virtual_environment_nodes.available_nodes.names)
  node_name    = element(data.proxmox_virtual_environment_nodes.available_nodes.names, random_integer.index.result)
  content_type = "snippets"
  datastore_id = local.datastore_snippets

  source_raw {
    data      = file("${path.module}/debian-vendor-config.yml")
    file_name = "debian-vendor-config.yml"
  }
}
