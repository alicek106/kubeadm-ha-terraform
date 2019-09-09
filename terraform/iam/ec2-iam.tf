##########################
# IAM: Policies and Roles
##########################

# The following Roles and Policy are mostly for future use

resource "aws_iam_role" "kubeadm_ha_iam_role" {
  name = "kubeadm_ha_iam_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Role policy
resource "aws_iam_role_policy" "kubeadm_ha_role_policy" {
  name = "kubeadm_ha_role_policy"
  role = "${aws_iam_role.kubeadm_ha_iam_role.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action" : ["ec2:*"],
      "Effect": "Allow",
      "Resource": ["*"]
    },
    {
      "Action" : ["elasticloadbalancing:*"],
      "Effect": "Allow",
      "Resource": ["*"]
    },
    {
      "Action": "route53:*",
      "Effect": "Allow",
      "Resource": ["*"]
    },
    {
      "Action": "ecr:*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}


# IAM Instance Profile for instances (worker + master)
resource  "aws_iam_instance_profile" "kubeadm_ha_instance_profile" {
  # Instance Profile name should be same with IAM Role
  # Because creating IAM Role also creates instance profile automatically
  # Error log : EntityAlreadyExists: Instance Profile
  # Reference : https://docs.aws.amazon.com/ko_kr/IAM/latest/UserGuide/id_roles_use_switch-role-ec2_instance-profiles.html
  name = "kubeadm_ha_iam_role"
  role = "${aws_iam_role.kubeadm_ha_iam_role.name}"
}
