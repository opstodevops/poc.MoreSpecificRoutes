resource "aws_security_group" "applicationsecuritygroup" {
  description = "SecurityGroup for application host"
  name        = "ApplicationInstancSecurityGroup"
  tags        = local.common_tags
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allows HTTP connection from bastion security group"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.bastionsecuritygroup.id]
  }

  egress {
    description = "Allow all outbound traffic by default"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# this rule depends on both security & appliance security groups 
# separating it to avoid cycle error & created after both  
resource "aws_security_group_rule" "appliance-to-application" {
  type                     = "ingress" 
  from_port                = 0 # narrow this
  to_port                  = 0
  protocol                 = "tcp"
  security_group_id        = aws_security_group.applicationsecuritygroup.id
  source_security_group_id = aws_security_group.appliancesecuritygroup.id
}

resource "aws_security_group" "bastionsecuritygroup" {
  description = "SecurityGroup for bastion host"
  name        = "BastionHostInstanceSecurityGroup"
  tags        = local.common_tags
  vpc_id      = var.vpc_id

  ingress {
    from_port = "22"
    to_port   = "22"
    protocol  = "TCP"
    # cidr_blocks = [var.public_ip_address]
    cidr_blocks = ["10.240.0.0/16", "10.242.0.0/16"]
    description = "Access from anywhere" # Accept from Xero offices
  }

  egress {
    description = "Allow all outbound traffic by default"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
  }
}

resource "aws_security_group" "appliancesecuritygroup" {
  description = "SecurityGroup for appliance host"
  name        = "ApplianceInstancSecurityGroup"
  tags        = local.common_tags
  vpc_id      = var.vpc_id
  
  ingress {
    description     = "Allows all connections from application security group" # narrow this
    from_port       = 0
    to_port         = 0
    protocol        = "tcp"
    security_groups = [aws_security_group.applicationsecuritygroup.id]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
    description = "from itself"
  }


  egress {
    description = "Allow all outbound traffic by default"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
