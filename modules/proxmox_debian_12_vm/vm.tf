resource "proxmox_virtual_environment_vm" "debian_template" {
  count           = var.vm_count
  node_name       = element(data.proxmox_virtual_environment_nodes.available_nodes.names, random_integer.index.result)
  name            = "${var.vm_name}-${count.index + 1}.${var.dns_suffix}"
  template        = false
  vm_id           = replace("${var.vm_ip_address_prefix}${count.index}", ".", "")
  machine         = "q35"
  started         = var.start_on_deploy
  tablet_device   = false
  stop_on_destroy = true
  migrate         = true
  bios            = "ovmf"
  on_boot         = var.start_on_boot

  agent {
    enabled = true
  }

  operating_system {
    type = "l26"
  }

  cpu {
    cores   = var.cpu_cores
    sockets = 1
    type    = "x86-64-v2-AES"
  }

  disk {
    datastore_id = local.datastore_images
    file_id      = proxmox_virtual_environment_download_file.debian_cloud_image.id
    interface    = "scsi0"
    ssd          = true
    size         = var.os_disk_size
  }

  scsi_hardware = "virtio-scsi-pci"
  boot_order    = ["scsi0"]

  network_device {
    firewall = false
    model    = "virtio"
    vlan_id  = 0
  }

  vga {
    type = "serial0"
    # type   = "virtio"
    # memory = 8
  }

  serial_device {
    device = "socket"
  }

  memory {
    dedicated = var.vm_memory
    floating  = var.vm_memory
  }

  efi_disk {
    datastore_id = local.datastore_images
    file_format  = "raw"
    type         = "4m"
  }

  tpm_state {
    datastore_id = local.datastore_images
    version      = "v2.0"
  }

  startup {
    order      = 0
    up_delay   = 2
    down_delay = 0
  }

  initialization {
    datastore_id = local.datastore_images
    interface    = "scsi1"

    dns {
      domain  = var.dns_suffix
      servers = var.dns_servers
    }
    user_account {
      username = var.cloudinit_username
      password = var.cloudinit_password
      keys     = var.cloudinit_ssh_keys
    }
    ip_config {
      ipv4 {
        address = "${var.vm_ip_address_prefix}${count.index}/${var.vm_ip_address_cidr_netmask}"
        gateway = var.vm_gateway
      }
    }
    vendor_data_file_id = proxmox_virtual_environment_file.debian_vendor_config.id
  }

  lifecycle {
    ignore_changes = [
      startup,
      on_boot
    ]
  }
}
