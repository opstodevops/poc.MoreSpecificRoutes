data "aws_caller_identity" "current" {}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "template_file" "install_apache" {
  template = file("${path.module}/files/install_apache.sh")
}

data "template_file" "fwd_traffic" {
  template = file("${path.module}/files/fwd_traffic.sh")
}

data "template_file" "add_user" {
  template = file("${path.module}/files/add_user.sh")
}

# User data for adding user
data "template_cloudinit_config" "bastion_config" {
  gzip          = true
  base64_encode = true

    part {
    filename     = "user.cfg"
    content_type = "text/x-shellscript"
    content      = "${data.template_file.add_user.rendered}"
  }

}

# User data for adding user & install apache
data "template_cloudinit_config" "application_config" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "apache.cfg"
    content_type = "text/x-shellscript"
    content      = "${data.template_file.install_apache.rendered}"
  }

  part {
    filename     = "user.cfg"
    content_type = "text/x-shellscript"
    content      = "${data.template_file.add_user.rendered}"
  }
}

# User data for adding user & forwarding traffic
data "template_cloudinit_config" "appliance_config" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "user.cfg"
    content_type = "text/x-shellscript"
    content      = "${data.template_file.add_user.rendered}"
  }

  part {
    filename     = "traffic.cfg"
    content_type = "text/x-shellscript"
    content      = "${data.template_file.fwd_traffic.rendered}"
  }
}