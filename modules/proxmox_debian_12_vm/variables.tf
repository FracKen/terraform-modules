variable "vm_image_name" {
  type        = string
  description = "This is the name of the debian cloud image, downloading from https://cloud.debian.org/images/cloud/bookworm/latest/"
  default     = "debian-12-genericcloud-amd64.qcow2"
}

variable "vm_ip_address_prefix" {
  type        = string
  description = "The IP address details, without the final digit, This module will append the count index as teh final digit"
}

variable "vm_ip_address_cidr_netmask" {
  type        = string
  description = "This is the CIDR subnet size in Bits"
}

variable "vm_gateway" {
  type        = string
  description = "This is the IP address of the gateway"
}

variable "dns_suffix" {
  type        = string
  description = "This is the DNS suffix for the VM"
}

variable "dns_servers" {
  type        = list(string)
  description = "This is the list of dns servers to use."
}

variable "vm_name" {
  type        = string
  description = "This is the name of the VM"
}

variable "cloudinit_username" {
  type        = string
  description = "This is the username for the cloudinit user"
}

variable "cloudinit_password" {
  type        = string
  description = "This is the password for the cloudinit user"
}

variable "cloudinit_ssh_keys" {
  type        = list(string)
  description = "This is the list of ssh keys for the cloudinit user"
}

variable "vm_count" {
  type        = number
  description = "This is the number of VMs to create"
  default     = 1
}

variable "cpu_cores" {
  type        = number
  description = "This is the number of CPU cores to use"
  default     = 1
}

variable "vm_memory" {
  type        = number
  description = "This is the amount of memory to use"
  default     = 1024
}

variable "start_on_boot" {
  type        = bool
  description = "This is whether to start the VM on host boot"
  default     = false
}

variable "start_on_deploy" {
  type        = bool
  description = "This is whether to start the VM after deployment"
  default     = true
}

variable "os_disk_size" {
  type        = number
  description = "This is the size of the OS disk"
  default     = 2
}
