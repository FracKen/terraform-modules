terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
    }
    http = {
      source = "hashicorp/http"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}
