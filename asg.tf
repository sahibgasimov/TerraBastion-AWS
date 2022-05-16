data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_configuration" "as_conf" {

  name_prefix     = "bastion-host"
  image_id        = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.key.key_name
  security_groups = [aws_security_group.ssh_access_for_bastion.id]

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_group" "asg" {
  name                 = "bastion_host"
  launch_configuration = aws_launch_configuration.as_conf.id
  min_size             = 1
  max_size             = 2
  vpc_zone_identifier  = [aws_subnet.public_1.id, aws_subnet.public_2.id]

  lifecycle {
    create_before_destroy = true
  }
  
    tags = concat(
  [
    {
      "Name" = "BastionHost"
    }])

}

resource "aws_key_pair" "key" {
  key_name   = "sahib"
  public_key = file(var.public_key)
}
