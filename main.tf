provider "azurerm" {
  features {}
}


resource "azurerm_kubernetes_cluster" "default" {
  name                = "${var.project_prefix}-aks"
  location            = var.azure_region
  resource_group_name = var.resource_group
  dns_prefix          = "${var.project_prefix}-k8s"

  default_node_pool {
    name            = "default"
    node_count      = var.k8s_cluster_node_count
    vm_size         = var.cluster_node_size
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = var.client_id_azurespn
    client_secret = var.client_id_password
  }

  role_based_access_control_enabled = true

  tags = {
    environment = var.k8s_cluster_environment_tag
  }
}




resource local_file kubeconfig {
  count    = var.generate_kubeconfig_file ? 1 : 0
  filename = "${path.module}/kubeconfig.yaml"
  content  = azurerm_kubernetes_cluster.default.kube_config_raw
}

resource "volterra_discovery" "cluster-discovery" {
  name      = format("%s-aksdiscovery-%s",var.project_prefix,var.instance_suffix)
  namespace = "system" // Always leave as "system" as Service Discovery objects are created under "System" namespace in XC

  // One of the arguments from this list "no_cluster_id cluster_id" must be set
  no_cluster_id = true

  description = format("Service discovery for AKS cluster %s", azurerm_kubernetes_cluster.default.name)
  
  discovery_k8s {
    access_info {
      kubeconfig_url {
        clear_secret_info {
          url = "string:///${base64encode(azurerm_kubernetes_cluster.default.kube_config_raw)}"
        }
      }
      isolated = true
    }
    publish_info {
      disable = true
    }
  }
  where {
    site {
      ref {
        name      = var.site_name
        namespace = "system" // Always leave as "system" as sites are created under "system" namespace on XC
      }
      network_type = "VIRTUAL_NETWORK_SITE_LOCAL_INSIDE"
    }
  }
}

terraform {
  required_version = ">= 0.12.7"

  required_providers {
    volterra = {
      source = "volterraedge/volterra"
     }
    }
}