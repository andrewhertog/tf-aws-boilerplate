variable "region" {
    description = "Region to launch aws resources in "
    default = "us-east-1"
}

variable "vpc_cidr_block" {
    description = "Cidr range to use for VPC"
    default = "10.0.0.0/16"
}

variable "vpc_name" {
    description = "Label to name VPC"
  
}

