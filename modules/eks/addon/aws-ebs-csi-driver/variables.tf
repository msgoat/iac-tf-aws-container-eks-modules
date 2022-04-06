# variables.tf
# ---------------------------------------------------------------------------
# Defines all input variable for this demo.
# ---------------------------------------------------------------------------

variable region_name {
  description = "The AWS region to deploy into (e.g. eu-central-1)."
  type = string
}

variable solution_name {
  description = "The name of the AWS solution that owns all AWS resources."
  type = string
}

variable solution_stage {
  description = "The name of the current AWS solution stage."
  type = string
}

variable solution_fqn {
  description = "The fully qualified name of the current AWS solution."
  type = string
}

variable common_tags {
  description = "Common tags to be attached to all AWS resources"
  type = map(string)
}

variable addon_enabled {
  description = "Controls if this addon is actually activated"
  type = bool
  default = true
}

variable eks_cluster_name {
  description = "Name of the target AWS EKS cluster"
  type = string
}

variable kube_config_file_name {
  description = "Full pathname of the kubeconfig file of the target AWS EKS cluster"
  type = string
}

variable kubernetes_namespace_name {
  description = "Name of the Kubernetes namespace"
  type = string
  default = "aws-ebs-csi"
}

variable helm_release_name {
  description = "Name of the Helm release"
  type = string
  default = "aws-ebs-csi-driver"
}