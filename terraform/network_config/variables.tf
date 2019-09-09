locals {
  common_tags = "${map(
    "kubernetes.io/cluster/${var.cluster_id_tag}", "${var.cluster_id_value}"
  )}"
}

##########################
# Default variables (you can change for customizing)
##########################

variable control_cidr {
  description = "CIDR for maintenance: inbound traffic will be allowed from this IPs"
  default = "0.0.0.0/0"
}

variable vpc_name {
  description = "Name of the VPC"
  default = "kubeadm-ha-vpc"
}

variable elb_name {
  description = "Name of the ELB for Kubernetes API"
  default = "kubernetes"
}

variable vpc_cidr {
  default = "20.43.0.0/16"
}

# Use from other modules
variable master_instance_id_list{
  type = "list"
}

# Inherit variables from root variables
variable region {
}

variable zone {
}

variable owner {
}

variable cluster_id_tag{
}

variable cluster_id_value{
}
