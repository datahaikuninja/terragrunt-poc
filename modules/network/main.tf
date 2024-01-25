resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "terragrunt-vpc-${var.env}"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "terragrunt-igw-${var.env}"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id = aws_vpc.this.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-northeast-1a"
  map_public_ip_on_launch = true
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "terragrunt-public-rt-${var.env}"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}
