output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = values(aws_subnet.public)[*].id
}

output "public_subnet_cidrs" {
  description = "Public subnet CIDR blocks"
  value       = values(aws_subnet.public)[*].cidr_block
}

output "region" {
  description = "AWS region"
  value       = var.aws_region
}
