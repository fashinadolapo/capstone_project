output "kubeconfig" {
  value = module.eks_cluster.kubeconfig
}

output "worker_instance_role_arn" {
  value = module.eks_workers.worker_instance_role_arn
}
