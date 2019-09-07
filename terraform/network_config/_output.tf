output "vpc" {
  value = "${aws_vpc.kubeadm_ha_vpc.id}"
}

output "subnet" {
  value = "${aws_subnet.kubeadm_ha_subnet.id}"
}
 
output "security_group" {
  value = "${aws_security_group.kubeadm_ha_security_group.id}"
}

output "internet_gateway" {
  value = "${aws_internet_gateway.kubeadm_ha_internet_gateway.id}"
}

output "vpc_dhcp_options" {
  value = "${aws_vpc_dhcp_options.kubeadm_ha_vpc_dhcp_options.id}"
}

output "route_table" {
  value = "${aws_route_table.kubeadm_ha_route_table.id}"
}

output "security_group_master_api_elb" {
  value = "${aws_security_group.kubeadm_ha_master_api_elb_security_group.id}"
}

output "vpc_cidr" {
  value = "${var.vpc_cidr}"
}

# We don't need it right now :D
output "api_elb_dns_name" {
  value = "${aws_elb.kubeadm_ha_api_elb.dns_name}"
}
