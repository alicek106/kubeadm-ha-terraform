module "aws_network_config" {
  source = "./network_config"
  
  # From another modules
  master_instance_id_list = "${module.aws_ec2.master_instance_id_list}"

  # Common variables
  region = "${var.region}"
  zone = "${var.zone}"
  owner = "${var.owner}"
  cluster_id_tag = "${var.cluster_id_tag}"
  cluster_id_value = "${var.cluster_id_value}"
}

module "aws_iam" {
  source = "./iam"
}

module "aws_ec2" {
  source = "./ec2"

  # From another modules
  vpc_cidr = "${module.aws_network_config.vpc_cidr}"
  subnet_id = "${module.aws_network_config.subnet}"
  vpc_security_group_id = "${module.aws_network_config.security_group}"
  instance_profile_id = "${module.aws_iam.instance_profile}"

  # Common variables
  region = "${var.region}"
  zone = "${var.zone}"
  owner = "${var.owner}"
  cluster_id_tag = "${var.cluster_id_tag}"
  cluster_id_value = "${var.cluster_id_value}"
}
