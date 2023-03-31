variable client_id_azurespn {
    type = string 
    description = "clientID value for Azure SPN"
}
variable client_id_password {
    type = string
    description = "clientID password for Azure SPN"
}
variable project_prefix {
    type = string
    description = "custom project prefix from parent terragrunt.hcl"
}
variable azure_region {
    type = string
    description = "Azure Region for site deployment"
}
variable resource_group {
    type = string
    description = "Resource group for resources in Azure Site"
}
variable cluster_node_size{
    type = string
    description = "Size of Nodes to be created for the AKS Node Pool"
    default = "Standard_B2s"
}
variable instance_suffix {
    type = string
    description = "Suffix instance value that co-relates to site and app"
}
variable namespace {
    type = string
}
variable site_name {
    type = string
}
variable volterra_tenant {
    type = string
}
variable k8s_cluster_node_count {
  type    = number
  default = 2
}
variable k8s_cluster_environment_tag {
  type    = string
  default = "Demo"
}
variable generate_kubeconfig_file {
  type    = bool
  default = false
}