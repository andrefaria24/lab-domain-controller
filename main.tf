# Domain Controller Security Group
resource "aws_security_group" "dc" {
  name        = "windows-domain-controller-sg"
  description = "RDP from admin IP and all traffic within VPC"
  vpc_id      = data.terraform_remote_state.aws-demo-network.outputs.vpc_id

  ingress {
    description = "RDP from admin IP"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = [var.RDP_CIDR]
  }

  ingress {
    description = "All traffic within VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [data.terraform_remote_state.aws-demo-network.outputs.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Domain Controller EC2 Instance
resource "aws_instance" "dc" {
  ami           = var.DC_AMI
  instance_type = "t3.large"
  key_name      = var.KEYPAIR
  subnet_id     = data.terraform_remote_state.aws-demo-network.outputs.pub_subnet_ids[0]

  vpc_security_group_ids = [aws_security_group.dc.id]

  tags = {
    Name = "dc-${var.AD_DOMAIN_NAME}"
  }
}

# Elastic IP for Domain Controller
resource "aws_eip" "dc" {
  domain = "vpc"
}

# Associate Elastic IP with Domain Controller
resource "aws_eip_association" "dc" {
  instance_id   = aws_instance.dc.id
  allocation_id = aws_eip.dc.id
}