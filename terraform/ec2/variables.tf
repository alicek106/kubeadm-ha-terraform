locals {
  common_tags = "${map(
    "kubernetes.io/cluster/${var.cluster_id_tag}", "${var.cluster_id_value}"
  )}"
}

variable number_of_master{
  description = "The number of master, only acts as master"
  default = 3
}

variable number_of_etcd{
  description = "The number of etcd, only acts as etcd"
  default = 3
}

variable number_of_worker{
  description = "The number of worker nodes"
  default = 3
}

variable default_keypair_name {
  description = "Name of the KeyPair used for all nodes"
  default = "kubeadm-ha"
}

variable amis {
  description = "Default AMIs to use for nodes depending on the region"
  type = "map"
  default = {
    ap-northeast-2 = "ami-067c32f3d5b9ace91"
    ap-northeast-1 = "ami-0567c164"
    ap-southeast-1 = "ami-a1288ec2"
    cn-north-1 = "ami-d9f226b4"
    eu-central-1 = "ami-8504fdea"
    eu-west-1 = "ami-0d77397e"
    sa-east-1 = "ami-e93da085"
    us-east-1 = "ami-40d28157"
    us-west-1 = "ami-6e165d0e"
    us-west-2 = "ami-a9d276c9"
  }
}

variable etcd_instance_type {
  default = "t2.small"
}
variable master_instance_type {
  default = "t2.medium"
}
variable worker_instance_type {
  default = "t2.medium"
}


## Use varialbes from another modules
variable vpc_cidr {
}

variable subnet_id {
}

variable vpc_security_group_id {
}

variable instance_profile_id {
}

## Inherit variables from root variables
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
