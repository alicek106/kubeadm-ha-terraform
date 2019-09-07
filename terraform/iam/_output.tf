output "instance_profile" {
  value = "${aws_iam_instance_profile.kubeadm_ha_instance_profile.id}"
}
