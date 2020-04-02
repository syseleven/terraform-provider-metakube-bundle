# SSH key path

variable "ssh_key" {
  description = "Path to the public key to be used for ssh access to the worker nodes"
  default     = "~/.ssh/id_rsa.pub"
}


# Project and cluster configuration

provider "metakube" {
  // Do not forget to set METAKUBE_API_TOKEN environment variable.
}

resource "metakube_project" "my-project" {
  // project name, in-place updatable
  name = "metakube"

  // project labels, in-place updatable
  labels = {
    "component" = "main"
  }
}

resource "metakube_cluster" "my-cluster" {
  project_id = metakube_project.my-project.id // change forces new

  labels = { // has in-place update.
    "environment" = "staging"
  }

  sshkeys = ["ssh-key"]

  name          = "metakube-cluster"   // has in-place update
  version       = "1.17.4"             // k8s version, change forces new
  dc            = "syseleven-dbl1"     // openstack datacenter, change forces new
  audit_logging = true                 // has in-place update

  // openstack
  tenant            = "tenant name"                       // change forces new
  provider_username = "openstack user"                   // sensitive, not persisted in tfstate, change forces new
  provider_password = "password"                         // sensitive, not persisted in tfstate, change forces new

  depends_on = [metakube_sshkey.ssh-key]

  // clusters node deployment
  nodedepl {
    name     = "worker-nodes"            // change forces new
    replicas = 3                         // has in-place update

    autoscale {
      min_replicas = 3 // optional, not setting and setting to zero have the same effect.
      max_replicas = 4 // optional, not setting and setting to zero have the same effect.
    }

    flavor          = "l1.small"                          // has in-place update
    image           = "Rescue Ubuntu 18.04 sys11"         // has in-place update
    use_floating_ip = true                                // has in-place update
  }
}

resource "metakube_sshkey" "ssh-key" {
  project_id = metakube_project.my-project.id // change foreces new

  name = "ssh-key"

  public_key = file(var.ssh_key)
}
