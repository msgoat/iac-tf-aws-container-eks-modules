resource helm_release aws_ebs_csi_driver {
  chart = "aws-ebs-csi-driver"
  version = "0.10.0"
  name = var.helm_release_name
  dependency_update = true
  atomic = true
  cleanup_on_fail = true
  namespace = module.namespace.kubernetes_namespace_name
  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  values = [templatefile("${path.module}/resources/helm/aws-ebs-csi-driver/values.template.yaml", {
    tf_ebs_csi_controller_role_arn = aws_iam_role.aws_ebs_csi_driver.arn
    tf_eks_cluster_name = var.eks_cluster_name
  })]
}