output "vpc_id" {
  description = "VPC ID"
  value = aws_vpc.this.id
}

output "vpc_subnet_public_a_id" {
  description = "VPC Subnet Public A ID"
  value = aws_subnet.public_a.id
}
