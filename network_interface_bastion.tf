resource "aws_network_interface" "bastion" {
  subnet_id       = aws_subnet.public_1.id
  private_ips     = ["10.0.11.199"]
  security_groups = [aws_security_group.ssh_access_for_bastion.id]
  tags = {
    Name = "Bastion"
  }

}
