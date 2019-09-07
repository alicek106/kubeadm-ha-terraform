output master_instance_id_list {
  value = ["${aws_instance.master.*.id}"]
}
