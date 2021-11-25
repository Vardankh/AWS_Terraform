# Declaring variables.

variable "aws_region" {
  type        = string
  description = "Declaring variable for Amazon Region"
  default     = "eu-west-1"
}

variable "cidr_vpc" {
  type        = string
  description = "Declaring variable for the cidr of the VPC"
  default     = "10.0.0.0/16"
}
variable "cidr_public1" {
  type        = string
  description = "Declaring variable for the cidr of the public1 subnet"
  default     = "10.0.1.0/24"
}

variable "cidr_public2" {
  type        = string
  description = "Declaring variable for the cidr of the public2 subnet"     
  default     = "10.0.2.0/24"
}

variable "cidr_web" {
  type        = string
  description = "Declaring variable for the cidr of the web private subnet"
  default     = "10.0.3.0/24"
}


