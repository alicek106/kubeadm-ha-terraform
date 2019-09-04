# Kubernetes HA Cluster

## Roadmap

This repository is planned to achieve below goals.

- HA Kubernetes cluster configurations
  - External etcd cluster (+3 nodes)
  - HA Master with internal Load Balancer (HAProxy + Heartbeat? ELB?) (+3 nodes)
  - Workers (+1 nodes)
- Create each manifests using kubeadm (*kubeadm* command respectively)
- **All infra provisioning should be automated by Terraform**
- **All installation should be automated by Ansible**

## Completed Jobs

- Cluster installation using kubeadm 1.15+ (HA Master with --upload-certs enabled)

## Planned Works

- Construct terraform files as modules
- Install packages using Ansible

## Additional Goals

- Cross-AZ HA (AWS)
- Multi region HA (AWS)
