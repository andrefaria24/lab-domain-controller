variable "DC_AMI" {
  type = string
}

variable "KEYPAIR" {
  type = string
}

variable "RDP_CIDR" {
  type        = string
  description = "CIDR allowed to RDP to the instance"
}

variable "AD_DOMAIN_NAME" {
  type = string
}

variable "AWS_REGION" {
  type    = string
  default = "us-west-2"
}