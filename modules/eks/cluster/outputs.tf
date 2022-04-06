output eks_cluster_arn {
  description = "Unique identifier of the AWS EKS cluster"
  value = aws_eks_cluster.control_plane.arn
}

output eks_cluster_name {
  description = "Name of the AWS EKS cluster"
  value = aws_eks_cluster.control_plane.name
}
