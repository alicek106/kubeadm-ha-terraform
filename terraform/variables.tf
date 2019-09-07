locals {
  common_tags = "${map(
    "kubernetes.io/cluster/${var.cluster_id_tag}", "${var.cluster_id_value}"
  )}"
}

locals {
  default_keypair_public_key = "${file("./keys/kubeadm-ha.pub")}"
}


## Common Variables which inherit to modules
variable region {
  default = "ap-northeast-2"
}

variable zone {
  default = "ap-northeast-2a"
}

variable owner {
  default = "alicek106"
}

variable cluster_id_tag{
  description = "Cluster ID tag for kubespray"
  default = "kubeadm-ha"
}

variable cluster_id_value{
  description = "Cluster ID value, it can be shared or owned"
  default = "owned"
}
