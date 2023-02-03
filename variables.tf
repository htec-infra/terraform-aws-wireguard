variable "namespace" {
  description = "Project namespace"
}

variable "cost_center" {
  type        = string
  description = "Resource tag for easier billing search and reports"
}

variable "environment" {
  type        = string
  description = "Full environment name tag (e.g. Development, Staging, Production)"
}

variable "env_code" {
  type        = string
  description = "Short environment name tag (e.g. dev, stg, prod)"
}

variable "root_domain" {
  type        = string
  description = "Domain name used to generate URL for Subspace UI"
}

variable "additional_tags" {
  type        = map(string)
  description = ""
  default     = {}
}

variable "subnet_ids" {
  description = "VPC subnet(s) identifier where to instantiate VPN server. Min 1 subnet id is required"
  type        = list(string)
}

variable "ingress_cidr_blocks" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "CIDR blocks allowed for incoming traffic"
}

variable "ingress_ipv6_cidr_blocks" {
  type        = list(string)
  default     = ["::/0"]
  description = "CIDR blocks allowed for incoming traffic"
}

variable "egress_cidr_blocks" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "CIDR blocks allowed for outgoing traffic"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "EC2 instance type"
}

variable "security_group_id" {
  type        = list(string)
  default     = []
  description = "List of Security Groups associated to the Wireguard instance"
}

variable "per_region_domain_name" {
  type        = bool
  default     = false
  description = "Per region domain name means that Subspace UI domain will be accessible on vpn.<region>.<root_domain> instead of regular vpn.<root_domain>"
}

variable "logs_retention_period" {
  type        = number
  default     = 90 # three months
  description = "Number of days how long the WireGuard logs will be kept in the CloudWatch storage."
}

variable "wg_ipv4_network" {
  description = "Internal VPN network space utilized by Wireguard server to maintain clients' identifiers."
}

variable "wg_allowed_ips" {
  type        = list(string)
  default     = []
  description = "CIDR format of allowed ip addresses used on the WireGuard client to route the traffic correctly. By default, VPC CIDR will be used."
}

variable "subspace_subdomain" {
  type        = string
  default     = "vpn"
  description = ""
}

variable "subspace_nameservers" {
  type    = list(string)
  default = []
}

variable "subspace_image" {
  type        = string
  default     = "subspacecommunity/subspace"
  description = "Subspace UI docker image"
}

variable "subspace_version" {
  type        = string
  default     = "1.5.0"
  description = "Version of the Subspace UI docker image."
}

variable "subspace_container_cpu" {
  type    = number
  default = 800
}

variable "subspace_container_memory" {
  type    = number
  default = 420
}

variable "subspace_theme" {
  type    = string
  default = "green"
}
