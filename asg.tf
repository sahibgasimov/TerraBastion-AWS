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

resource "aws_launch_template" "as_template" {
name_prefix = "sahib"
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 20
    }
  }
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  cpu_options {
    core_count       = 4
    threads_per_core = 2
  }
  credit_specification {
    cpu_credits = "standard"
  }
  ebs_optimized = true
  /* iam_instance_profile {
    name = "test"
  } */
  image_id = data.aws_ami.ubuntu.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t2.micro"
  key_name = aws_key_pair.key.key_name
  monitoring {
    enabled = true
  }
  network_interfaces {
    associate_public_ip_address = true
    network_interface_id =  aws_network_interface.bastion.id
    security_groups = ["${aws_security_group.ssh_access_for_bastion.id}"]
    subnet_id = "${aws_subnet.public_1.id}"
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Bastion"
    }
  }
/* user_data                   = "${file("./userdata.sh")}"   */
}


resource "aws_autoscaling_group" "asg" {
  name                 = "bastion_host"
  launch_template {
     id = aws_launch_template.as_template.id
     version = "${aws_launch_template.as_template.latest_version}"
  }

  min_size             = 1
  max_size             = 2
  vpc_zone_identifier  = [aws_subnet.public_1.id, aws_subnet.public_2.id]


  lifecycle {
    create_before_destroy = true
  }


  tag {
    key                 = "Name"
    value               = "Bastion"
    propagate_at_launch = true
  }

}

resource "aws_key_pair" "key" {
  key_name   = "sahib"
  public_key = file(var.public_key)
}

