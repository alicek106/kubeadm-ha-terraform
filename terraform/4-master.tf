############################
# K8s Control Pane instances
############################

resource "aws_instance" "master" {
    count = "${var.number_of_master}"
    ami = "${lookup(var.amis, var.region)}"
    instance_type = "${var.master_instance_type}"

    iam_instance_profile = "${aws_iam_instance_profile.kubernetes.id}"

    subnet_id = "${module.aws_network_config.subnet}"
    private_ip = "${cidrhost(var.vpc_cidr, 20 + count.index)}"
    associate_public_ip_address = true # Instances have public, dynamic IP
    source_dest_check = false # TODO Required??

    availability_zone = "${var.zone}"
    vpc_security_group_ids = ["${module.aws_network_config.security_group}"]
    key_name = "${var.default_keypair_name}"
    tags = "${merge(
    local.common_tags,
      map(
        "Owner", "${var.owner}",
        "Name", "master-${count.index}"
      )
    )}"
}


###############################
## Kubernetes API Load Balancer
###############################

resource "aws_elb" "kubernetes_api" {
    name = "${var.elb_name}"
    instances = ["${aws_instance.master.*.id}"]
    subnets = ["${module.aws_network_config.subnet}"]
    cross_zone_load_balancing = false

    security_groups = ["${module.aws_network_config.security_group_master_api_elb}"]

    listener {
      lb_port = 6443
      instance_port = 6443
      lb_protocol = "TCP"
      instance_protocol = "TCP"
    }

    health_check {
      healthy_threshold = 2
      unhealthy_threshold = 2
      timeout = 15
      target = "HTTPS:6443/"
      interval = 30
    }

    tags = "${merge(
      local.common_tags,
        map(
          "Name", "kubernetes",
          "Owner", "${var.owner}"
        )
    )}"
}

output "kubernetes_api_dns_name" {
  value = "${aws_elb.kubernetes_api.dns_name}"
}
