module "aws_network_config" {
  source = "./network_config"
  region = "${var.region}"
  zone = "${var.zone}"
  owner = "${var.owner}"
  cluster_id_tag = "${var.cluster_id_tag}"
  cluster_id_value = "${var.cluster_id_value}"
}
