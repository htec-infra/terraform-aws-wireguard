variable "context" {}

variable "cost_center" {
  type = string
}

variable "iam_prefix" {
  type = string
}

variable "environment" {
  type = string

}

variable "root_domain" {
  type = string
  description = "Domain name used to generate URL for Subspace UI"
}

variable "create_vpn" {
  default = false
}

variable "vpc_id" {
  description = "VPC used to instantiate EC2 for VPN server"
}

variable "instance_type" {
  type = string
  default     = "t3.micro"
  description = "EC2 instance type"
}

variable "security_group_id" {
  type    = list(string)
  default = []
  description = "List of Security Groups associated to the Wireguard instance"
}

variable "per_region_domain_name" {
  type    = bool
  default = false
  description = "Per region domain name means that Subspace UI domain will be accessible on vpn.<region>.<root_domain> instead of regular vpn.<root_domain>"
}

variable "key_pair_name" {
  default = ""
  description = "EC2 instance keyname that can be used for SSH access directly to the EC2 instance or as a Jump host as a VPN alternative."
}

variable "subspace_ipv4_network" {
  description = "Internal VPN network space"
}

variable "subspace_version" {
  type = string
  default = "1.3.1"
  description = "Version of the Subspace UI docker image."
}

variable "subspace_allowed_ips" {
  type = string
  default = "0.0.0.0/0"
  description = "CIDR format of allowed ip addresses used on the Wireguard client to route the traffic correctly."
}

