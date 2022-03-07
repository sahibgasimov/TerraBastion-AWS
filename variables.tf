variable "common_tags" {
  description = "Common Tags to apply to all resources"
  type        = map
  default = {
    Owner       = "Sahib Gasimov"
    Project     = "Phoenix"
    CostCenter  = "12345"
    Environment = "development"
  }
}



variable "allow_ports" {
  description = "List of Ports to open for server"
  type        = list
  default     = ["22"]
}

variable "public_key" {
  type        = string
  description = "Please provide your public_key"
  default     = "~/.ssh/id_rsa.pub"
}

