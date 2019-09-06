resource "aws_internet_gateway" "kubeadm_ha_internet_gateway" {
  vpc_id = "${aws_vpc.kubeadm_ha_vpc.id}"

  tags = "${merge(
    local.common_tags,
    map(
        "Name", "kubernetes",
        "Owner", "${var.owner}"
    )
  )}"
}
