locals {
  common_tags = "${map(
    "kubernetes.io/cluster/${var.cluster_id_tag}", "${var.cluster_id_value}"
  )}"
}

#############################
# Adjustable variables
#############################

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

variable cluster_id_tag{
  description = "Cluster ID tag for kubespray"
  default = "kubeadm-ha"
}

variable cluster_id_value{
  description = "Cluster ID value, it can be shared or owned"
  default = "owned"
}

##########################
# Default variables (you can change for customizing)
##########################

variable control_cidr {
  description = "CIDR for maintenance: inbound traffic will be allowed from this IPs"
  default = "0.0.0.0/0"
}

locals {
  default_keypair_public_key = "${file("./keys/kubeadm-ha.pub")}"
}

/*
## It triggers interpolation. It is recommended to use another way.
## TODO : Replace default_keypair_public_key as output?
variable default_keypair_public_key {
  description = "Public Key of the default keypair"
  default = "${file("../keys/tf-kube.pub")}"
}
*/

variable default_keypair_name {
  description = "Name of the KeyPair used for all nodes"
  default = "kubeadm-ha"
}

variable vpc_name {
  description = "Name of the VPC"
  default = "kubeadm-ha-vpc"
}

variable elb_name {
  description = "Name of the ELB for Kubernetes API"
  default = "kubernetes"
}

variable owner {
  default = "alicek106"
}

# Networking setup
variable region {
  default = "ap-northeast-2"
}

variable zone {
  default = "ap-northeast-2a"
}

### VARIABLES BELOW MUST NOT BE CHANGED ###

variable vpc_cidr {
  default = "20.43.0.0/16"
}

# Instances Setup
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


# Unused Variables
/*
variable kubernetes_pod_cidr {
  default = "10.200.0.0/16"
}

variable kubernetes_cluster_dns {
  default = "10.31.0.1"
}

variable default_instance_user {
  default = "ubuntu"
}
*/
