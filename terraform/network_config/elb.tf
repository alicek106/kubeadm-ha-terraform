###############################
## Kubernetes API Load Balancer
###############################

resource "aws_elb" "kubeadm_ha_api_elb" {
    name = "kubeadm-ha-api-elb"
    instances = ["${var.master_instance_id_list}"]
    subnets = ["${aws_subnet.kubeadm_ha_subnet.id}"]
    cross_zone_load_balancing = false
    security_groups = ["${aws_security_group.kubeadm_ha_security_group.id}"]
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
          "Name", "kubeadm-ha-api-elb",
          "Owner", "${var.owner}"
        )
    )}"
}
