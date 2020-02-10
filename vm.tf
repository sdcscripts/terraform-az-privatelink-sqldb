module "windowsservers" {
  nb_instances                  = 1
  source                        = "Azure/compute/azurerm"
  resource_group_name           = "${azurerm_resource_group.rgmain.name}"
  location                      = "${azurerm_resource_group.rgmain.location}"
  vm_hostname                   = "${var.vm_hostname}" // line can be removed if only one VM module per resource group
  admin_username                = "${var.vm_admin_user}"
  admin_password                = "${var.vm_admin_pwd}"
  vm_os_simple                  = "WindowsServer"
  is_windows_image              = "true"
  public_ip_dns                 = ["${var.vm_public_dns_prefix}${random_id.randomId.hex}"] // change to a unique name per datacenter region
  vnet_subnet_id                = "${module.network.vnet_subnets[0]}"
  vm_size                       = "${var.vm_size}"
  delete_os_disk_on_termination = true
}

// Following creation, can use choco to install SSMS quickly 
/* 
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 # You need to run this to default TLS1.2 which the site now requires.
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install sql-server-management-studio
*/