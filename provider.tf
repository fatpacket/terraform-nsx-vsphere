# 
terraform {
  required_providers {
    nsxt = {
      source = "vmware/nsxt"
    }
    vsphere = {
      source = "hashicorp/vsphere"
    }
  }
}

# Configure the VMware NSX-T Provider
provider "nsxt" {
  host                 = var.nsx["ip"]
  username             = var.nsx["user"]
  password             = var.nsx["password"]
  allow_unverified_ssl = true
}


# Configure the VMware vSphere Provider
provider "vsphere" {
  user                 = var.vsphere["vsphere_user"]
  password             = var.vsphere["vsphere_password"]
  vsphere_server       = var.vsphere["vsphere_ip"]
  allow_unverified_ssl = true
}