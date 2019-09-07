#########################
# etcd cluster instances
#########################
resource "aws_instance" "etcd" {
    count = "${var.number_of_etcd}"
    ami = "${lookup(var.amis, var.region)}"
    instance_type = "${var.etcd_instance_type}"
    subnet_id = "${var.subnet_id}"
    private_ip = "${cidrhost(var.vpc_cidr, 10 + count.index)}"
    associate_public_ip_address = true # Instances have public, dynamic IP
    availability_zone = "${var.zone}"
    vpc_security_group_ids = ["${var.vpc_security_group_id}"]
    key_name = "${var.default_keypair_name}"
    tags = "${merge(
    local.common_tags,
      map(
        "Owner", "${var.owner}",
        "Name", "etcd-${count.index}"
      )
    )}"
}
