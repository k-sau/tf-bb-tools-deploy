locals {
  config = jsondecode(file("config/config.json"))
}

variable "droplet_name" {
  default = "tf-tools"
}

variable "droplet_size" {
  default = "s-2vcpu-2gb"
}

variable "droplet_region" {
  default = "sfo3"
}

variable "droplet_image" {
  default = "ubuntu-20-04-x64"
}