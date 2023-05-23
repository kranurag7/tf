resource "aws_instance" "server" {
  count         = var.instance_count
  ami           = var.aws_ami
  instance_type = var.aws_instance_type
  key_name      = aws_key_pair.gen_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.extl-secgroup.id]
  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }
  tags = {
    hack      = "yes"
  }
}

# Automatically generated key 'gen_tls_pk':
resource "tls_private_key" "gen_tls_pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Automatically generated key_pair 'gen_key_pair':
resource "aws_key_pair" "gen_key_pair" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.gen_tls_pk.public_key_openssh
}

# File to save .pem key to:
resource "local_file" "key_local_file" {
  content         = tls_private_key.gen_tls_pk.private_key_pem
  filename        = var.key_file
  file_permission = "0400"
}

resource "aws_security_group" "extl-secgroup" {
  name = "extl-secgroup"
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Enable ssh external server connection:
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ips" {
  value = [for ip in aws_instance.server.*.public_ip : "ssh -i ~/tf/${var.key_file} ${var.ssh_username}@${ip}"]
}