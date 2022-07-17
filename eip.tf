#create eip for Bastion host
resource "aws_eip" "bastion" {
  vpc                       = true
  tags = {
    Name = "bastion"
  }
}

#associate Bastion eip with bastion network interface to be able to attach to launch template
resource "aws_eip_association" "eip_assoc" {
  allocation_id = aws_eip.bastion.id
  network_interface_id = aws_network_interface.bastion.id
}