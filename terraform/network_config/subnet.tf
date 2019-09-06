# Subnet (public)
resource "aws_subnet" "kubeadm_ha_subnet" {
  vpc_id = "${aws_vpc.kubeadm_ha_vpc.id}"
  cidr_block = "${var.vpc_cidr}"
  availability_zone = "${var.zone}"

  tags = "${merge(
    local.common_tags,
    map(
        "Name", "kubernetes",
        "Owner", "${var.owner}"
    )
  )}"
}
