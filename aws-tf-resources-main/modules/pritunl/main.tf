data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "aura-tfstates"
    key    = "${var.vpc_env != null ? var.vpc_env : var.env}/vpc.tfstate"
    region = var.region
  }
}

module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = ">= 6.0"

  name                        = var.name
  instance_type               = var.instance_type # Recommended for Pritunl
  ami                         = var.ami != null ? var.ami : data.aws_ami.ubuntu.id
  subnet_id                   = element(data.terraform_remote_state.network.outputs.public_subnets, 0)
  vpc_security_group_ids      = [module.pritunl_sg.security_group_id]
  associate_public_ip_address = true
  user_data                   = base64encode(templatefile("${path.module}/user-data.sh", {}))

  # IAM role for SSM access
  create_iam_instance_profile = true
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  tags = var.tags
}

# Security Group for Pritunl
module "pritunl_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "${var.name}-pritunl-sg"
  description = "Pritunl VPN security group"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "HTTP access"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "HTTPS access"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 1194
      to_port     = 1194
      protocol    = "udp"
      description = "VPN access"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow all outbound"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = var.tags
}

# Ubuntu AMI lookup
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}
