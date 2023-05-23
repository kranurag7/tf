variable "aws_ami" {
  # default = "ami-04581fbf744a7d11f" # Amazon Linux 2022 AMI (BPFLSM)
  default = "ami-0557a15b87f6559cf" # Ubuntu instnace
  # default = "ami-0508167db03652cc4" # Nix Instance us-east-1
}

variable "region" {
  default = "us-east-1"
}

variable "instance_count" {
  default = 1
}

variable "aws_instance_type" {
  default = "t2.medium"
}

variable "key_pair_name" {
  type    = string
  default = "aws_key"
}

variable "key_file" {
  type    = string
  default = "aws_key.pem"
}

variable "ssh_username" {
  description = "The username to use for SSH connections"
  default     = "ubuntu"
}
