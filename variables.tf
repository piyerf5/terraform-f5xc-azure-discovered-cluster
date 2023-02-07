variable clientID_azurespn {
    type = string 
    description = "clientID value for Azure SPN"
}

variable clientID_password {
    type = string
    description = "clientID password for Azure SPN"
}

variable projectPrefix {
    type = string
    description = "custom project prefix from parent terragrunt.hcl"
}
variable azureRegion {
    type = string
    description = "Azure Region for site deployment"
}
variable resourceGroup {
    type = string
    description = "Resource group for resources in Azure Site"
}
variable clusterNodeSize{
    type = string
    description = "Size of Nodes to be created for the AKS Node Pool"
    default = "Standard_B2s"
}
variable instanceSuffix {
    type = string
    description = "Suffix instance value that co-relates to site and app"
}
variable namespace {
    type = string
}
variable site_name {
    type = string
}

variable volterraTenant {
    type = string
}