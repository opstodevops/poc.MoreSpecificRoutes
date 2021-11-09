resource "aws_instance" "bastionhost" {
  ami                    = "ami-0c2d06d50ce30b442"
  instance_type          = "t3.nano"
  availability_zone      = "us-west-2a" # hard coded
  tenancy                = "default"
  subnet_id              = "subnet-08fb29835d6a5d913" # hard coded
  ebs_optimized          = false
  vpc_security_group_ids = [aws_security_group.bastionsecuritygroup.id]
  source_dest_check      = true
  root_block_device {
    volume_size           = 8
    volume_type           = "gp2"
    delete_on_termination = true
  }
  user_data = data.template_cloudinit_config.bastion_config.rendered
  iam_instance_profile = aws_iam_instance_profile.bastionprofile.id

  tags = {
    Name        = "bastion"
    ssm-enabled = "true"
    ssm-os      = "linux"
    uuid        = local.common_tags.uuid
  }
}

resource "aws_instance" "appliancehost" {
  ami                    = "ami-0c2d06d50ce30b442"
  instance_type          = "t3.nano"
  availability_zone      = "us-west-2b" # hard coded
  tenancy                = "default"
  subnet_id              = "subnet-023f88523851cd4fa" # hard coded
  ebs_optimized          = false
  vpc_security_group_ids = [aws_security_group.appliancesecuritygroup.id]
  source_dest_check      = false
  root_block_device {
    volume_size           = 8
    volume_type           = "gp2"
    delete_on_termination = true
  }
  # user_data            = file("${path.module}/files/install_apache.sh")
  user_data = data.template_cloudinit_config.appliance_config.rendered
  iam_instance_profile = aws_iam_instance_profile.applianceprofile.id

  tags = {
    Name        = "appliance"
    ssm-enabled = "true"
    ssm-os      = "linux"
    uuid        = local.common_tags.uuid
  }
}

resource "aws_instance" "applicationhost" {
  ami                    = "ami-0c2d06d50ce30b442"
  instance_type          = "t3.nano"
  availability_zone      = "us-west-2c" # hard coded
  tenancy                = "default"
  subnet_id              = "subnet-0b617fbb48b788c06" # hard coded
  ebs_optimized          = false
  vpc_security_group_ids = [aws_security_group.applicationsecuritygroup.id]
  source_dest_check      = true
  root_block_device {
    volume_size           = 8
    volume_type           = "gp2"
    delete_on_termination = true
  }
  # user_data            = file("${path.module}/files/install_apache.sh")
  user_data = data.template_cloudinit_config.application_config.rendered
  iam_instance_profile = aws_iam_instance_profile.applicationprofile.id

  tags = {
    Name        = "application"
    ssm-enabled = "true"
    ssm-os      = "linux"
    uuid        = local.common_tags.uuid
  }
}