
############################################
# K8s Worker (aka Nodes, Minions) Instances
############################################

resource "aws_instance" "worker" {
    count = "${var.number_of_worker}"
    ami = "${lookup(var.amis, var.region)}"
    instance_type = "${var.worker_instance_type}"
    iam_instance_profile = "${var.instance_profile_id}"
    subnet_id = "${var.subnet_id}"
    private_ip = "${cidrhost(var.vpc_cidr, 30 + count.index)}"
    associate_public_ip_address = true # Instances have public, dynamic IP
    source_dest_check = false # TODO Required??

    availability_zone = "${var.zone}"
    vpc_security_group_ids = ["${var.vpc_security_group_id}"]
    key_name = "${var.default_keypair_name}"

    tags = "${merge(
    local.common_tags,
      map(
        "Owner", "${var.owner}",
        "Name", "worker-${count.index}"
      )
    )}"
}

output "kubernetes_workers_public_ip" {
  value = "${join(",", aws_instance.worker.*.public_ip)}"
}