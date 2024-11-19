locals {
  datastore_container_templates = data.proxmox_virtual_environment_datastores.datastores.datastore_ids[
    index([for v in data.proxmox_virtual_environment_datastores.datastores.content_types : contains(v, "vztmpl")], true)
  ]
  datastore_images = data.proxmox_virtual_environment_datastores.datastores.datastore_ids[
    index([for v in data.proxmox_virtual_environment_datastores.datastores.content_types : contains(v, "images")], true)
  ]
  datastore_iso = data.proxmox_virtual_environment_datastores.datastores.datastore_ids[
    index([for v in data.proxmox_virtual_environment_datastores.datastores.content_types : contains(v, "iso")], true)
  ]
  datastore_snippets = data.proxmox_virtual_environment_datastores.datastores.datastore_ids[
    index([for v in data.proxmox_virtual_environment_datastores.datastores.content_types : contains(v, "snippets")], true)
  ]
  matched_line = regexall(local.sha512_pattern, data.http.checksum_file.response_body)
  sha512_hash = length(local.matched_line) > 0 ? local.matched_line[0][0] : null
  sha512_pattern = "([a-f0-9]{128})\\s+${var.vm_image_name}"
}