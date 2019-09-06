resource "aws_vpc" "kubeadm_ha_vpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags = "${merge(
    local.common_tags,
    map(
        "Name", "${var.vpc_name}",
        "Owner", "${var.owner}"
    )
  )}"
}

# DHCP Options are not actually required, being identical to the Default Option Set
resource "aws_vpc_dhcp_options" "kubeadm_ha_vpc_dhcp_options" {
  domain_name = "${var.region}.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = "${merge(
    local.common_tags,
    map(
        "Name", "${var.vpc_name}",
        "Owner", "${var.owner}"
    )
  )}"
}

resource "aws_vpc_dhcp_options_association" "kubeadm_ha_vpc_dhcp_options_association" {
  vpc_id ="${aws_vpc.kubeadm_ha_vpc.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.kubeadm_ha_vpc_dhcp_options.id}"
}
