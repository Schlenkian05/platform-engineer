variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet where NAT instance will be created"
  type        = string
}

variable "private_route_table_id" {
  description = "Private Route Table ID"
  type        = string
}

variable "instance_type" {
  description = "NAT Instance Type"
  type        = string
  default     = "t3.nano"
}
