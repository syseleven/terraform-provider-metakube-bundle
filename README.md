# MetaKube Terraform Provider:

This repo contains the first version of out MetaKube Terraform Provider.
I included an example main.tf to create a MetaKube cluster. At the moment we support the following features:

* Project creation
* Cluster creation
* Cluster deltion
* Adding MetaKube Worker
* Adding Labels to cluster
* Add SSH keys to your projects
* Add SSH keys to your worker nodes
* Cluster upgrades (Master and worker nodes separate upgrades are not possible)

Coming soon:

* Adding Addons to your MetaKube cluster
* Support for the cloud providers AWS and Azure

Howto use:

* Edit the main.tf to include your openstack credentials, cluster and image name
* download teraform from hashicorp or install with brew
* export the Metakube API Token with export METAKUBE_API_TOKEN=""
* terraform init (initialise terraform)
* terraform validate (validate your configuration)
* terraform apply (apply your configuration and create your cluster)
* when you finshed with your cluster you can clean up with terraform destroy (beware this will delete all of your resources)


If you would like to build the provider yourself. Or have a look at the code here is the source code repository:

https://gitlab.com/furkhat/terraform-provider-metakube
