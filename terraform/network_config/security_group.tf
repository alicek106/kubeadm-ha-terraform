# For Cluster Nodes
resource "aws_security_group" "kubeadm_ha_security_group" {
  vpc_id = "${aws_vpc.kubeadm_ha_vpc.id}"
  name = "kubeadm_ha_security_group"

  # Allow all outbound
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow ICMP from control host IP
  ingress {
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["${var.control_cidr}"]
  }

  # Allow all internal
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  # Allow all traffic from the API ELB
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_groups = ["${aws_security_group.kubeadm_ha_master_api_elb_security_group.id}"]
  }

  # Allow all traffic from control host IP
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["${var.control_cidr}"]
  }

  tags = "${merge(
    local.common_tags,
    map(
        "Name", "kubeadm_ha_security_group",
        "Owner", "${var.owner}"
    )
  )}"
}

# For Master API ELB 
resource "aws_security_group" "kubeadm_ha_master_api_elb_security_group" {
  vpc_id = "${aws_vpc.kubeadm_ha_vpc.id}"
  name = "kubeadm_ha_master_api_elb"

  # Allow inbound traffic to the port used by Kubernetes API HTTPS
  ingress {
    from_port = 6443
    to_port = 6443
    protocol = "TCP"
    cidr_blocks = ["${var.control_cidr}"]
  }

  # Allow all outbound traffic
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(
    local.common_tags,
      map(
        "Name", "kubeadm_ha_master_api_elb",
        "Owner", "${var.owner}"
      )
  )}"
}
