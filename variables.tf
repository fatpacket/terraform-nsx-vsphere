# configure some variables first 
variable "nsx" {
  type        = map(string)
  description = "NSX Login Details"
}
variable "vsphere" {
  type        = map(string)
  description = "vSphere Details"
}
variable "nsx_data_vars" {
  type        = map(string)
  description = "Existing NSX vars for data sources"
}
variable "nsx_rs_vars" {
  type        = map(string)
  description = "NSX vars for the resources"
}
variable "nsx_tag_scope" {
  type        = string
  description = "Scope for the tag that will be applied to all resources"
}
variable "nsx_tag" {
  type        = string
  description = "Tag, the value for the scope above"
}
/** variable "ipset" {
  type        = list(string)
  description = "List of ip addresses that will be add in the IP-SET to allow communication to all VMs"
} **/
variable "app_listen_port" {
  type        = string
  description = "TCP Port the App server listens on"
}
variable "db_user" {
  type        = string
  description = "DB Details"
}
variable "db_pass" {
  type        = string
  description = "DB Details"
}
variable "db_name" {
  type        = string
  description = "DB Details"
}
variable "web" {
  type        = map(string)
  description = "NSX vars for the resources"
}
variable "app" {
  type        = map(string)
  description = "NSX vars for the resources"
}
variable "db" {
  type        = map(string)
  description = "NSX vars for the resources"
}
variable "dns_server_list" {
  type        = list(string)
  description = "DNS Servers"
}