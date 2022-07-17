resource "aws_network_interface" "bastion" {
  subnet_id       = aws_subnet.public_1.id
  private_ips     = ["10.0.11.199"]
  tags = {
    Name = "Bastion"
  }

}
