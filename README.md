# Kubernetes HA Cluster

## Roadmap

This repository is planned to achieve below goals.

- HA Kubernetes cluster configurations
  - External etcd cluster (+3 nodes)
  - HA Master with internal Load Balancer (HAProxy + Heartbeat? ELB?) (+3 nodes)
  - Workers (+1 nodes)
- Create each manifests using kubeadm (*kubeadm* command respectively)
- **All steps should be automated by Terraform**

## Additional Goals

- Cross-AZ HA (AWS)
- Multi region HA (AWS)
