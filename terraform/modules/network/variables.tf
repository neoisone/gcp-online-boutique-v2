variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "ob-vpc"
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "ob-subnet"
}

variable "region" {
  description = "Region for subnet"
  type        = string
  default     = "us-central1"
}
