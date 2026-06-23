variable "public_subnet_id" {
  description = "Public subnet for NAT Gateway"
  type        = string
}

variable "private_route_table_id" {
  description = "Private route table ID"
  type        = string
}
