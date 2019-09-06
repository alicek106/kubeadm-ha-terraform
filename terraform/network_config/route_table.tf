############
## Routing
############

resource "aws_route_table" "kubeadm_ha_route_table" {
   vpc_id = "${aws_vpc.kubeadm_ha_vpc.id}"

   # Default route through Internet Gateway
   route {
     cidr_block = "0.0.0.0/0"
     gateway_id = "${aws_internet_gateway.kubeadm_ha_internet_gateway.id}"
   }

  tags = "${merge(
    local.common_tags,
    map(
        "Name", "kubernetes",
        "Owner", "${var.owner}"
    )
  )}"
}

resource "aws_route_table_association" "kubeadm_ha_route_table_association" {
  subnet_id = "${aws_subnet.kubeadm_ha_subnet.id}"
  route_table_id = "${aws_route_table.kubeadm_ha_route_table.id}"
}
