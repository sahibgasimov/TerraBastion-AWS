output "SomeOutput" {
  value = <<EOF

        Private_EC2 has the following IP address   ${aws_instance.private_ec2[0].private_dns}
        DB_EC2 has the following IP address   ${aws_instance.db[0].private_dns}
    EOF
}

output "vpc" {
  value = aws_vpc.main.id
}
output "public_subnets" {
  value = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id,
  ]
}
output "private_subnets" {
  value = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id,
  ]
}
output "db_subnets" {
  value = [
    aws_subnet.db_1.id,
    aws_subnet.db_2.id,
  ]
}