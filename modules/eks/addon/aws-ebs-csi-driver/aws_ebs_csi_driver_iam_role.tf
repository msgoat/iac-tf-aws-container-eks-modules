locals {
  oidc_provider_id = replace(data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer, "https://", "")
}

resource aws_iam_role aws_ebs_csi_driver {
  name = "role-${var.eks_cluster_name}-ebs-csi-driver"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.oidc_provider_id}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "${local.oidc_provider_id}:sub": "system:serviceaccount:${var.kubernetes_namespace_name}:ebs-csi-controller-sa"
        }
      }
    }
  ]
}
POLICY
  tags = merge({
    Name =  "role-${var.eks_cluster_name}-ebs-csi-driver"
  }, local.module_common_tags)
}

resource aws_iam_role_policy aws_ebs_csi_driver {
  name = "policy-${var.eks_cluster_name}-ebs-csi-driver"
  role = aws_iam_role.aws_ebs_csi_driver.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:AttachVolume",
        "ec2:CreateSnapshot",
        "ec2:CreateTags",
        "ec2:CreateVolume",
        "ec2:DeleteSnapshot",
        "ec2:DeleteTags",
        "ec2:DeleteVolume",
        "ec2:DescribeAvailabilityZones",
        "ec2:DescribeInstances",
        "ec2:DescribeSnapshots",
        "ec2:DescribeTags",
        "ec2:DescribeVolumes",
        "ec2:DescribeVolumesModifications",
        "ec2:DetachVolume",
        "ec2:ModifyVolume"
      ],
      "Resource": "*"
    }
  ]
}
POLICY
}