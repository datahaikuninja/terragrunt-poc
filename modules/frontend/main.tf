data "aws_ami" "amzn_linux_2023_ami" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "web" {
  ami = data.aws_ami.amzn_linux_2023_ami.id
  instance_type = "t3.micro"
  subnet_id = var.public_subnet_id

  tags = {
    Name = "terragrunt-web-${var.env}"
  }
}

resource "aws_security_group" "web" {
  name = "terragrunt-sg-web-${var.env}"
  description = "Security group for web servers"
  vpc_id = var.vpc_id

  tags = {
    Name = "terragrunt-sg-web-${var.env}"
  }
}

resource "aws_security_group_rule" "web_inbound_http" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web.id
}

resource "aws_security_group_rule" "web_outbound_all" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web.id
}
