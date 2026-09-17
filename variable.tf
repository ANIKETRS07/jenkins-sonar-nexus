variable "vpc_cidr_block" {
    description = "cidr value for vpc creation"
    type = string
    default = "10.0.0.0/16"
}

variable "environment" {
  description = "Environment for vpc creation"
  type        = string
  default     = "dev"
}

variable "mypublicsubnet_cidr_block" {
  description = "CIDR for mypublicsubnet_ creation"
  type        = string
  default     = "10.0.0.0/24"
}

variable "mypublicsubnet_2_cidr_block" {
  description = "CIDR for mypublicsubnet_2 creation"
  type        = string
 default     = "10.0.3.0/24"
}

variable "myprivatesubnet_cidr_block" {
  description = "CIDR for myprivatesubnet creation"
  type        = string
   default     = "10.0.1.0/24"
}

variable "myprivatesubnet_2_cidr_block" {
  description = "CIDR for myprivatesubnet_2 creation"
  type        = string
   default     = "10.0.2.0/24"
}

