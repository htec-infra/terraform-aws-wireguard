variable "namespace" {
  description = "Project namespace"
}

variable "cost_center" {
  type        = string
  description = "Resource tag for easier billing search and reports"
}

//variable "iam_prefix" {
//  type        = string
//  description = "Prefix for IAM roles"
//}

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

//variable "create_vpn" {
//  default = false
//}

//variable "vpc_id" {
//  description = "VPC used to instantiate EC2 for VPN server. It has to contain 3 subnets with tags Tier:Public"
//  validation {
//    condition     = length(var.vpc_id) > 4 && substr(var.vpc_id, 0, 4) == "vpc-"
//    error_message = "The vpc_id value must be a valid VPC id, starting with \"vpc-\"."
//  }
//}

variable "subnet_ids" {
  description = "VPC subnet(s) identifier where to instantiate VPN server. Min 1 subnet id is required"
  type        = list(string)
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

variable "key_pair_name" {
  default     = ""
  description = "EC2 instance keyname that can be used for SSH access directly to the EC2 instance or as a Jump host as a VPN alternative."
}

variable "subspace_ipv4_network" {
  description = "Internal VPN network space utilized by Wireguard server to maintain clients' identifiers."
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

variable "subspace_allowed_ips" {
  type        = list(string)
  default     = []
  description = "CIDR format of allowed ip addresses used on the WireGuard client to route the traffic correctly. By default, VPC CIDR will be used."
}

