resource "aws_iam_policy_attachment" "ssmmanagedpolicy_attach" {
  name       = "SSMManagedInstanceCore-attachment"
  roles      = [aws_iam_role.appliancerole.id, aws_iam_role.bastionrole.id, aws_iam_role.applicationrole.id]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy" "appliancerole_policy" {
  name = "appliancerole_policy"
  role = aws_iam_role.appliancerole.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ssmmessages:*",
          "ssm:UpdateInstanceInformation",
          "ec2messages:*",
        ],
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role" "appliancerole" {
  name = "SpecificRoutingDemo-SpecificRoutingAppliance"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = local.common_tags
}

resource "aws_iam_instance_profile" "applianceprofile" {
  name = "applianceprofile"
  role = aws_iam_role.appliancerole.id
}

resource "aws_iam_role_policy" "bastionrole_policy" {
  name = "bastionrole_policy"
  role = aws_iam_role.bastionrole.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ssmmessages:*",
          "ssm:UpdateInstanceInformation",
          "ec2messages:*",
        ],
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role" "bastionrole" {
  name = "SpecificRoutingDemo-SpecificRoutingBastion"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = local.common_tags
}

resource "aws_iam_instance_profile" "bastionprofile" {
  name = "bastionprofile"
  role = aws_iam_role.bastionrole.id
}

resource "aws_iam_role_policy" "applicationrole_policy" {
  name = "applicationrole_policy"
  role = aws_iam_role.applicationrole.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ssmmessages:*",
          "ssm:UpdateInstanceInformation",
          "ec2messages:*",
        ],
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role" "applicationrole" {
  name = "SpecificRoutingDemo-SpecificRoutingapplication"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = local.common_tags
}

resource "aws_iam_instance_profile" "applicationprofile" {
  name = "applicationprofile"
  role = aws_iam_role.applicationrole.id
}