Azure Private Link - SQL DB Simple Deployment
=============================================

This code will quickly (usually within 5-6 mins) build a simple deployment of an Azure SQL Database instance and a Windows 2016 VM. A private DNS zone is also created and the Private Link Endpoint IP is registered. 

Three resource groups are deployed, one for the compute resources, another for the networking components (including Private Link) and a third for the SQL components

## Requirements

* terraform core 0.12.n
* tested with terraform AzureRM provider `1.39.0`
* an authenticated connection to an azure subscription (or add service principal info to the azurerm provider block)


> Deploying this module will incur cost in your subscription!


The key points and features are:

- **Easy Run**: There is a `terraform.tfvars.example` file which you should rename to `terraform.tfvars` and you will then need to set the passwords for the vmadmin and sqladmin accounts. All other variable entries can be used or you can optionally set them to new values if you wish. Afterwards, simply run Terraform init, Terraform Apply  and it will deploy into UK South.  

- **Network Security Group Rules**: This deployment will automatically attach an NSG rule to the VM that is created which means port 3389 will be open publically. Be aware of this, you may wish to disallow this and set up alternative methods to remote to the VM such as Azure Bastion, VPN or Expressroute. 

Terraform Getting Started & Documentation
-----------------------------------------

If you're new to Terraform and want to get started creating infrastructure, please checkout our [Getting Started](https://www.terraform.io/intro/getting-started/install.html) guide, available on the [Terraform website](http://www.terraform.io).

All documentation is available on the [Terraform website](http://www.terraform.io):

  - [Intro](https://www.terraform.io/intro/index.html)
  - [Docs](https://www.terraform.io/docs/index.html)